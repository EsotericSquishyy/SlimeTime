extends Phase

var enemies = []

func begin():
    print("BEGIN ENEMY PHASE")

func handle(_delta):
    return get_parent().GamePhase.ENEMY

func end():
    print("END ENEMY PHASE")
