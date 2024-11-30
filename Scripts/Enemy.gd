extends Node2D

var health_points   : int
var damage          : int
var detect_rad      : float
var trace_path      : Callable

var next_pos : Vector2
var lerp_speed = 3.0

func init(resource : EnemyData):
    health_points   = resource.health_points
    damage          = resource.damage
    detect_rad      = resource.detect_rad

    $AnimatedSprite2D.sprite_frames = resource.sprite_frames

    match resource.movement_type:
        resource.MovementType.TIMID:
            trace_path = timid_pathing
        resource.MovementType.NEUTRAL:
            trace_path = neutral_pathing
        resource.MovementType.AGGRESSIVE:
            trace_path = aggressive_pathing

func is_target_visible(player_position: Vector2) -> bool:
    return position.distance_to(player_position) < detect_rad

func timid_pathing():
    pass

func neutral_pathing():
    pass

func aggressive_pathing():
    pass
