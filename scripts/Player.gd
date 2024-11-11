extends Node2D

var path = []
var lerp_speed = 5.0
var next_pos: Vector2
var moving = false
var lerp_tolerance = 1.0

func _process(delta):
    if moving:
        move_towards_target(delta)

func trace_route(direction: Vector2):
    var tile_center = position.snapped(Vector2(32, 32)) + direction * 32
    path.append(tile_center)
    if not moving:
        start_moving()

func start_moving():
    if path.size() > 0:
        next_pos = path.pop_front()
        moving = true

func move_towards_target(delta):
    position = position.lerp(next_pos, lerp_speed * delta)
    if position.distance_to(next_pos) < lerp_tolerance:
        position = next_pos
        moving = false
        # Transition to animation phase logic here

