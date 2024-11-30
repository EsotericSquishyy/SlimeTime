extends Node

var tileMap : TileMap
var player : Node2D
var cursor : Node2D

enum GamePhase {
    PLAYER,
    PLAYER_ANIM,
    ENEMY,
    ENEMY_ANIM
}

var currentPhase : GamePhase
@onready var phaseDict : Dictionary = {
    GamePhase.PLAYER: $PlayerPhase,
    GamePhase.PLAYER_ANIM: $PlayerAnimPhase,
    GamePhase.ENEMY: $EnemyPhase,
    GamePhase.ENEMY_ANIM: $EnemyAnimPhase
}

func init(tileMap : TileMap, player : Node2D, cursor : Node2D):
    self.tileMap = tileMap
    self.player = player
    self.cursor = cursor

    currentPhase = GamePhase.PLAYER
    await get_tree().physics_frame
    await get_tree().physics_frame
    phaseDict[currentPhase].begin()

func _process(delta):        
    tileMap.update_cursor_pos()
    cursor.position = tileMap.get_cursor_pos_global()
    
    var nextPhase = phaseDict[currentPhase].handle(delta)

    if nextPhase != currentPhase:
        phaseDict[currentPhase].end()
        phaseDict[nextPhase].begin()
        currentPhase = nextPhase
