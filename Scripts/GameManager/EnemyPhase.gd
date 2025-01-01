extends Phase

var _enemy_manager : Node

func init():
    _enemy_manager = get_parent().get_enemy_manager()

func begin():
    _enemy_manager.load_enemies()
    
    print("BEGIN ENEMY PHASE")

func handle(_delta):
    return get_parent().GamePhase.ENEMY_ANIM

func end():
    print("END ENEMY PHASE")
