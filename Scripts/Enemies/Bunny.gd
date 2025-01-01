extends Enemy

func _set_movement_animation():
    $AnimationPlayer.stop() 
    
    var diff = _next_position - _curr_position
    
    if diff.x > 0:
        $AnimatedSprite2D.play("Moving_Bottom_Right")
    elif diff.x < 0:
        $AnimatedSprite2D.play("Moving_Top_Left")
    elif diff.y > 0:
        $AnimatedSprite2D.play("Moving_Bottom_Left")
    elif diff.y < 0:
        $AnimatedSprite2D.play("Moving_Top_Right")
    else:
        $AnimatedSprite2D.stop()
        $AnimationPlayer.play("Idle")
