extends Phase

func begin():
    print("BEGIN PLAYER PHASE")

func handle(delta):
    return get_parent().GamePhase.PLAYER
    
func end():
    print("END PLAYER PHASE")
