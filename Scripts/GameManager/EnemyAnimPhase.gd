extends Phase

var _enemy_manager : Node
var _enemy : Node2D

func init():
    _enemy_manager = get_parent().get_enemy_manager()

func begin():
    _enemy = _enemy_manager.get_enemy()
    _enemy.generate_paths()
    print(_enemy.get_move_path())
    print("BEGIN ENEMY ANIM PHASE")

func handle(_delta):
    return get_parent().GamePhase.ENEMY_ANIM
    
func end():
    print("END ENEMY ANIM PHASE")
