extends Phase

func begin():
    print("BEGIN PLAYER ANIM PHASE")

func handle(delta):
    return get_parent().GamePhase.PLAYER_ANIM
    
func end():
    print("END PLAYER ANIM PHASE")
