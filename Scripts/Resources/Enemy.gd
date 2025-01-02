extends Node2D

class_name Enemy

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

# Attack vars
var _attacking : bool

func init():
    _tileMap = get_parent().get_tileMap()
    _player = get_parent().get_player()
    
    self.position = _tileMap.map_to_global(_curr_position)
    _tileMap.set_unit(_curr_position, self)

# Path generation functions
var _to_from : Dictionary
var _path : Array[Vector2i]

func generate_paths():
    # Initialization       
    _to_from = {_curr_position: null}
    _path = []

    # BFS pathfinding algorithm
    var queue = [_curr_position]

    for i in range(0, _num_moves):
        for j in range(0, queue.size()):
            var from = queue.pop_front()

            var tos = [
                Vector2i(from.x - 1, from.y), Vector2i(from.x + 1, from.y), 
                Vector2i(from.x, from.y - 1), Vector2i(from.x, from.y + 1)
            ]
            randomize()
            tos.shuffle()

            for to in tos:
                if _tileMap.is_tile(to) and not _to_from.has(to) and is_crossable(to):
                    queue.append(to)
                    _to_from[to] = from
                    
    # Path scoring
    var _curr_score = 0
    if _choose_lowest_scoring_path:
        _curr_score = 2147483647 # sure... why not
    else:
        _curr_score = -2147483648
    
    var end = _curr_position
    
    for to in _to_from.keys():
        var score = scorePath(to)
        
        if (_choose_lowest_scoring_path and score < _curr_score) or (not _choose_lowest_scoring_path and score > _curr_score):
            _curr_score = score
            end = to
            
    # Path reconstruction
    _path.append(end)
    
    while _to_from[_path.back()] != null:
        _path.append(_to_from[_path.back()])
        
    _path.reverse()

func scorePath(to : Vector2i):
    if _tileMap.get_unit(to) != null:
        if _choose_lowest_scoring_path:
            return 2147483647
        else:
            return -2147483648
    
    return _tileMap.euclidean_distance(to, _player.get_tile_pos())

# Movement functions
func begin_move(next_position : Vector2i):
    _completion = 0
    _prev_position = _curr_position
    _next_position = next_position
    
    _set_movement_animation()

func move(delta):
    _completion += _move_speed * delta
    
    if _completion >= 1.0:
        _curr_position = _next_position
        self.position = _tileMap.map_to_global(_next_position)

        return true
    
    self.position = _tileMap.map_to_global(_prev_position).lerp(_tileMap.map_to_global(_next_position), _completion)
    
    return false

func _set_movement_animation():
    pass
    
# Attack functions
func can_attack():
    return false

func begin_attack():
    _attacking = true
    _start_attack_animation()

func _start_attack_animation():
    pass

func attack(delta):
    return not _attacking
    
func end_attack():
    _attacking = false

# Helper functions
func die():
    queue_free()

func is_crossable(tile : Vector2i):
    return _tileMap.is_crossable(tile)
    
func get_move_path():
    return _path
    
func get_health():
    return _health
    
func get_damage():
    return _damage
    
func get_slime():
    return _slime

func get_tile_pos():
    return _curr_position
