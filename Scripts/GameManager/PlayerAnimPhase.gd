extends Phase

var _player : Node2D
var _tileMap : TileMap
var _path : Array

func begin():
    _player = get_parent().get_player()
    _tileMap = get_parent().get_tileMap()
    _path = get_parent().get_global_path()
    _player.begin_move(_path.pop_front())
    print("BEGIN PLAYER ANIM PHASE")

func handle(delta):
    if _player.move(delta):
        if len(_path) == 0:
            return get_parent().GamePhase.PLAYER
        else:
            _player.begin_move(_path.pop_front())
            
    return get_parent().GamePhase.PLAYER_ANIM

func end():
    print("END PLAYER ANIM PHASE")

