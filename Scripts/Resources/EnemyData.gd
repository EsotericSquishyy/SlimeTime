extends Resource

class_name EnemyData

enum MovementType {
    TIMID,
    NEUTRAL,
    AGGRESSIVE,
}

@export var health_points : int
@export var damage : int
@export var detect_rad : float
@export var sprite_frames : SpriteFrames
@export var movement_type : MovementType

