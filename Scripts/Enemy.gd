extends Node2D

var _tileMap : TileMap
var _player : Node2D

# Gameloop vars
@export var _health : int
@export var _damage : int
@export var _slime : int
@export var _choose_lowest_scoring_path : bool
@export var _num_moves: int

# Movement vars
@export var _move_speed : float
var _completion : float
var _prev_position : Vector2i
@export var _curr_position : Vector2i
var _next_position : Vector2i

func init():
    _tileMap = get_parent().get_tileMap()
    _player = get_parent().get_player()
    
    self.position = _tileMap.map_to_global(_curr_position)
    _tileMap.set_unit(_curr_position, self)

# Path generation functions
var _paths = []
var _path = []
var _curr_score : int

func generate_paths():
    if _choose_lowest_scoring_path:
        _curr_score = 2147483647 # IG?
    else:
        _curr_score = -2147483648
        
    _paths.append(_curr_position)
    _generate_path(0)
    
func _generate_path(depth : int):
    var to = _paths.back()
    
    if not (depth <= _num_moves and _tileMap.is_tile(to) and is_crossable(to)):
        _paths.pop_back()
        return
    
    var score = scorePath()
    if (_choose_lowest_scoring_path and score < _curr_score) or (not _choose_lowest_scoring_path and score > _curr_score):
        _path = _paths.duplicate()
        _curr_score = score
    
    _paths.append(Vector2i(to.x - 1, to.y))
    _generate_path(depth + 1)
    
    _paths.append(Vector2i(to.x + 1, to.y))
    _generate_path(depth + 1)
    
    _paths.append(Vector2i(to.x, to.y - 1))
    _generate_path(depth + 1)
    
    _paths.append(Vector2i(to.x, to.y + 1))
    _generate_path(depth + 1)
    
    _paths.pop_back()

func scorePath():
    return _tileMap.euclidean_distance(_paths.back(), _player.get_tile_pos())

# Movement functions

# Helper functions
func is_crossable(tile : Vector2i):
    return _tileMap.is_crossable(tile)
    
func get_health():
    return _health
    
func get_damage():
    return _damage
    
func get_slime():
    return _slime

func get_tile_pos():
    return _curr_position
