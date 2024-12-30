extends Enemy

func _set_movement_animation():
    $AnimationPlayer.stop() 
    # .pause() makes bunnies sync animations, but looks weird when bunny moves just when it was about to eat
    
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
        $AnimatedSprite2D.pause()
        $AnimationPlayer.play("Idle")
