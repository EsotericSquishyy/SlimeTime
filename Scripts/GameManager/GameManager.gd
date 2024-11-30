extends Node

var _tileMap : TileMap
var _player : Node2D
var _cursor : Node2D
var _path : Array[Vector2i]
var _enemyManager : Node

enum GamePhase {
    PLAYER,
    PLAYER_ANIM,
    ENEMY,
    ENEMY_ANIM
}

var _currentPhase : GamePhase
@onready var _phaseDict : Dictionary = {
    GamePhase.PLAYER: $PlayerPhase,
    GamePhase.PLAYER_ANIM: $PlayerAnimPhase,
    GamePhase.ENEMY: $EnemyPhase,
    GamePhase.ENEMY_ANIM: $EnemyAnimPhase
}

func init(tileMap : TileMap, player : Node2D, cursor : Node2D, enemyManager : Node):
    _tileMap = tileMap
    _player = player
    _cursor = cursor
    _path = []
    _enemyManager = enemyManager

    _currentPhase = GamePhase.PLAYER
    await get_tree().physics_frame
    await get_tree().physics_frame
    _phaseDict[_currentPhase].begin()

func _process(delta):
    _tileMap.update_cursor_pos()
    _cursor.position = _tileMap.get_cursor_pos_global()

    var nextPhase = _phaseDict[_currentPhase].handle(delta)

    if nextPhase != _currentPhase:
        _phaseDict[_currentPhase].end()
        _phaseDict[nextPhase].begin()
        _currentPhase = nextPhase

func get_tileMap():
    return _tileMap

func get_player():
    return _player

func set_path(path):
    _path = path
    return

func get_global_path():
    return _path.map(_tileMap.map_to_global)

func get_enemy_dict():
    pass



