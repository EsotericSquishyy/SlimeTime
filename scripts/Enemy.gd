extends Node2D

var next_pos: Vector2
var lerp_speed = 3.0
var moving = false
var detect_rad = 100

func _process(delta):
    if moving:
        move_towards_target(delta)

func is_target_visible(player_position: Vector2) -> bool:
    return position.distance_to(player_position) < detect_rad

func move_towards_player(player_position: Vector2):
    if is_target_visible(player_position):
        next_pos = player_position # change to pathfind
        moving = true

func move_towards_target(delta):
    position = position.lerp(next_pos, lerp_speed * delta)
    if position.distance_to(next_pos) < 1.0:
        position = next_pos
        moving = false
        # Transition to animation phase logic here

