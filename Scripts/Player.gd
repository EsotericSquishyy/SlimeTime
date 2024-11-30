extends Node2D

const ANIMATION_PLAYER_BIG = preload("res://Animations/Slime_Animations/Player_Big.tres")
const ANIMATION_PLAYER_NORMAL = preload("res://Animations/Slime_Animations/Player_Normal.tres")
const ANIMATION_PLAYER_SMALL = preload("res://Animations/Slime_Animations/Player_Small.tres")

#func _ready():
    #$AnimatedSprite2D.sprite_frames = ANIMATION_PLAYER_BIG
    #$AnimatedSprite2D.play("Idle")

func _process(delta):
    pass
