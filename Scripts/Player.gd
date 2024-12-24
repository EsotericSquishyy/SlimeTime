extends Node2D

const _ANIMATION_PLAYER_BIG = preload("res://Animations/Slime_Animations/Player_Big.tres")
const _ANIMATION_PLAYER_NORMAL = preload("res://Animations/Slime_Animations/Player_Normal.tres")
const _ANIMATION_PLAYER_SMALL = preload("res://Animations/Slime_Animations/Player_Small.tres")

# Gameloop vars
@export var _slime_count : int

# Movement vars
@export var _move_speed : float
var _tileMap : TileMap
var _completion : float
var _prev_position : Vector2i
@export var _curr_position : Vector2i
var _next_position : Vector2i

func init(tileMap : TileMap):

    _tileMap = tileMap
    self.position = _tileMap.map_to_global(_curr_position)
    _tileMap.set_unit(_curr_position, self)
    
    if not _tileMap.is_slimed(_curr_position):
        _tileMap.toggle_slimed(_curr_position)

# Movement functions
func begin_move(next_position : Vector2i):
    _completion = 0
    _prev_position = _curr_position
    _next_position = next_position
    set_animation()

func move(delta):
    _completion += _move_speed * delta
    
    if _completion >= 1.0:
        _curr_position = _next_position
        self.position = _tileMap.map_to_global(_next_position)
        set_animation()
        return true
    
    self.position = _tileMap.map_to_global(_prev_position).lerp(_tileMap.map_to_global(_next_position), _completion)
    
    return false

func set_animation():
    var diff = _next_position - _curr_position
    
    if diff.x > 0:
        $AnimatedSprite2D.play("Moving_Bottom_Right")
    elif diff.x < 0:
        $AnimatedSprite2D.play("Moving_Upper_Left")
    elif diff.y > 0:
        $AnimatedSprite2D.play("Moving_Bottom_Left")
    elif diff.y < 0:
        $AnimatedSprite2D.play("Moving_Upper_Right")
    else:
        $AnimatedSprite2D.play("Idle")

# Helper functions  
func get_slime_count():
    return _slime_count
    
func set_slime_count(count : int):
    _slime_count = count

func get_tile_pos():
    return _curr_position
