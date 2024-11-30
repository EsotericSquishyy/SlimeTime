extends Phase

func begin():
    print("BEGIN ENEMY ANIM PHASE")

func handle(_delta):
    return get_parent().GamePhase.ENEMY_ANIM
    
func end():
    print("END ENEMY ANIM PHASE")
