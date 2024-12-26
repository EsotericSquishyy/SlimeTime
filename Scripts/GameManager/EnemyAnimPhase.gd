extends Phase

enum EnemyAnimState {
    ATTACKING,
    MOVING
}

var _state : EnemyAnimState
var _player : Node2D
var _enemy_manager : Node
var _tileMap : TileMap

func init():
    _player = get_parent().get_player()
    _enemy_manager = get_parent().get_enemy_manager()
    _tileMap = get_parent().get_tileMap()

func begin():
    _state = EnemyAnimState.MOVING
    
    handle_next_enemy()
    
    print("BEGIN ENEMY ANIM PHASE")

func handle(delta):
    match _state:
        EnemyAnimState.ATTACKING:
            return _handle_attack(delta)
        EnemyAnimState.MOVING:
            return _handle_move(delta)
            
func handle_next_enemy():
    var enemy = _enemy_manager.get_enemy()
    if enemy == null:
        return
    
    enemy.generate_paths()
    var path = enemy.get_move_path()
    if path.size() > 1:
        _tileMap.set_unit(path.pop_front(), null)
    
    if enemy.can_attack():
        enemy.begin_attack()
        
        _state = EnemyAnimState.ATTACKING
    else:
        _state = EnemyAnimState.MOVING
                
        if path.size() > 1:
            enemy.begin_move(path.front())
        else:
            _enemy_manager.next_enemy() # May cause stack overflow if a bunch of enemies don't attack or move, see method
    
func _handle_move(delta):
    var enemy = _enemy_manager.get_enemy()
    if enemy == null:
        return get_parent().GamePhase.PLAYER
        
    if enemy.move(delta):
        var path = enemy.get_move_path()
        var curr_pos = path.pop_front()
        
        if path.is_empty():
            _tileMap.set_unit(curr_pos, enemy)
            
        if enemy.can_attack():
            enemy.begin_attack()
            _state = EnemyAnimState.ATTACKING
        else:
            if path.is_empty():
                _enemy_manager.next_enemy()
                
                if _enemy_manager.get_enemy() == null:
                    return get_parent().GamePhase.PLAYER
            else:
                enemy.begin_move(path.front())
    
    return get_parent().GamePhase.ENEMY_ANIM
    
func _handle_attack(_delta):
    var enemy = _enemy_manager.get_enemy()
    
    if enemy.attack():
        _player.set_slime_count(_player.get_slime_count() - enemy.get_damage())
    
        var path = enemy.get_move_path()
        
        if path.is_empty():
            _enemy_manager.next_enemy()
                
            if _enemy_manager.get_enemy() == null:
                return get_parent().GamePhase.PLAYER
        else:
            enemy.begin_move(path.front())
            _state = EnemyAnimState.MOVING
    
    return get_parent().GamePhase.ENEMY_ANIM
    
func end():
    print("END ENEMY ANIM PHASE")
