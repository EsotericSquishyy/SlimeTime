extends Phase

var enemies = []

func begin():
    print("BEGIN ENEMY PHASE")

func handle(delta):
    return get_parent().GamePhase.ENEMY

func end():
    print("END ENEMY PHASE")
