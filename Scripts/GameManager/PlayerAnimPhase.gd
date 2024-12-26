extends Phase

enum PlayerAnimState {
    ATTACKING,
    MOVING
}

var _state : PlayerAnimState
var _player : Node2D
var _tileMap : TileMap
var _path : Array[Vector2i]

func init():
    _player = get_parent().get_player()
    _tileMap = get_parent().get_tileMap()

func begin():
    _path = get_parent().get_player_path()
    
    _tileMap.set_unit(_path.pop_front(), null)
    
    if _tileMap.get_unit(_path.front()) != null:
        _player.begin_attack(_path.front())
        _state = PlayerAnimState.ATTACKING
    else:
        _state = PlayerAnimState.MOVING
        _player.begin_move(_path.front())
        
    print("BEGIN PLAYER ANIM PHASE")

func handle(delta):
    match _state:
        PlayerAnimState.ATTACKING:
            return _handle_attack(delta)
        PlayerAnimState.MOVING:
            return _handle_move(delta)
    
func _handle_move(delta):
    if _player.move(delta):
        _tileMap.set_unit(_path.front(), _player)
    
        if not _tileMap.is_slimed(_path.front()):
            _tileMap.toggle_slimed(_path.front())
            _player.set_slime_count(_player.get_slime_count() - _tileMap.get_cost(_path.front()))
            
        var curr_pos = _path.pop_front()
        
        if _path.is_empty():
            return get_parent().GamePhase.ENEMY
        else:
            _tileMap.set_unit(curr_pos, null)
            
            if _tileMap.get_unit(_path.front()) != null:
                _player.begin_attack(_path.front())
                _state = PlayerAnimState.ATTACKING
            else:
                _player.begin_move(_path.front())
            
    return get_parent().GamePhase.PLAYER_ANIM
    
func _handle_attack(_delta):
    if _player.attack():
        var enemy = _tileMap.get_unit(_path.front())
        _player.set_slime_count(_player.get_slime_count() - enemy.get_health() + enemy.get_slime())
        _tileMap.set_unit(_path.front(), null)
        enemy.queue_free() # Death animation???
        
        _state = PlayerAnimState.MOVING
        _player.begin_move(_path.front())
    
    return get_parent().GamePhase.PLAYER_ANIM

func end():
    print("END PLAYER ANIM PHASE")
