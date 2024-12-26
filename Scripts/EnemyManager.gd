extends Node

var _tileMap : TileMap
var _player : Node2D
var _enemy_anim_phase : Phase
var _enemies : Array[Node]

func init(tileMap : TileMap, player : Node2D, enemy_anim_phase : Phase):
    _tileMap = tileMap
    _player = player
    _enemy_anim_phase = enemy_anim_phase
    
    for enemy in get_children():
        enemy.init()

func load_enemies():
    _enemies = get_children().duplicate()
    _enemies.reverse()
    
func get_enemy():
    if _enemies.is_empty():
        return null
    
    return _enemies.back()
    
func next_enemy():
    if not _enemies.is_empty():
        _enemies.pop_back()
        
    _enemy_anim_phase.handle_next_enemy()

func get_tileMap():
    return _tileMap

func get_player():
    return _player
    
