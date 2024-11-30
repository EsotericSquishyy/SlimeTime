extends Phase

var _player : Node2D
var _tileMap : TileMap
var _path : Array
var _next_pos: Vector2
var _lerp_speed = 5.0
var _lerp_tolerance = 1

func begin():
    _player = get_parent().get_player()
    _tileMap = get_parent().get_tileMap()
    _path = get_parent().get_global_path()
    _next_pos = _path.pop_front()
    print("BEGIN PLAYER ANIM PHASE")

func handle(delta):
    _player.position = _player.position.lerp(_next_pos, _lerp_speed * delta)
    if _player.position.distance_to(_next_pos) < _lerp_tolerance:
        _player.position = _next_pos
        if len(_path) == 0:
            return get_parent().GamePhase.ENEMY
        else:
            _next_pos = _path.pop_front()
    return get_parent().GamePhase.PLAYER_ANIM

func end():
    print("END PLAYER ANIM PHASE")

