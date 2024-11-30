extends Node2D

const _ANIMATION_PLAYER_BIG = preload("res://Animations/Slime_Animations/Player_Big.tres")
const _ANIMATION_PLAYER_NORMAL = preload("res://Animations/Slime_Animations/Player_Normal.tres")
const _ANIMATION_PLAYER_SMALL = preload("res://Animations/Slime_Animations/Player_Small.tres")

const _MOVE_SPEED = 2.0

var completion : float
var prev_position : Vector2
var next_position : Vector2

func begin_move(next_position : Vector2):
    completion = 0
    prev_position = self.position
    self.next_position = next_position
    set_animation()

func move(delta):
    completion += _MOVE_SPEED * delta
    
    if completion >= 1:
        self.position = next_position
        set_animation()
        return true
    
    self.position = prev_position.lerp(next_position, completion)
    
    return false

func set_animation():
    if self.position == next_position:
        $AnimatedSprite2D.play("Idle")
        return
    
    var angle = rad_to_deg(self.position.angle_to_point(next_position))
    
    if angle > 0 and angle < 90:
        $AnimatedSprite2D.play("Moving_Bottom_Right")
    elif angle > 90 and angle < 180:
        $AnimatedSprite2D.play("Moving_Bottom_Left")
    elif angle < 0 and angle > -90:
        $AnimatedSprite2D.play("Moving_Upper_Right")
    elif angle < -90 and angle > -180:
        $AnimatedSprite2D.play("Moving_Upper_Left") 
