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

    for key in _phaseDict:
        _phaseDict[key].init()
        
    _enemyManager = enemyManager
    _enemyManager.init(_tileMap, _player);

    _currentPhase = GamePhase.PLAYER
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

func get_move_path():
    return _path
