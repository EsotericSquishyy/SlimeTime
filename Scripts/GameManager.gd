extends Node

enum GameState {
    PLAYER,
    ANIM_PLAYER,
    ENEMY,
    ANIM_ENEMY
}

var tileMap : TileMap
var cursor : Node2D

var current_state: GameState = GameState.PLAYER
    
func init(tileMap : TileMap, cursor : Node2D):
    self.tileMap = tileMap
    self.cursor = cursor
    
func _ready():
    pass    
    
func _process(_delta):
    match current_state:
        GameState.PLAYER:
            handle_player_phase()
        GameState.ANIM_PLAYER:
            handle_animation_phase()
        GameState.ENEMY:
            handle_enemy_phase()
        GameState.ANIM_ENEMY:
            handle_enemy_animation_phase()

func handle_player_phase():
    # ...
    var cursor_pos = tileMap.get_cursor_pos()
    cursor.position = cursor_pos

    current_state = GameState.ANIM_PLAYER

func handle_animation_phase():
    # ...
    current_state = GameState.ENEMY

func handle_enemy_phase():
    # ...
    current_state = GameState.ANIM_ENEMY

func handle_enemy_animation_phase():
    # ...
    current_state = GameState.PLAYER

