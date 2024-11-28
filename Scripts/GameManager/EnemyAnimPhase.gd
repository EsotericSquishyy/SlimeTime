extends Phase

func begin():
    print("BEGIN ENEMY ANIM PHASE")

func handle(delta):
    return get_parent().GamePhase.ENEMY_ANIM
    
func end():
    print("END ENEMY ANIM PHASE")
