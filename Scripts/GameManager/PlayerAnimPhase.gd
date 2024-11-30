extends Phase

var player : Node2D
var tileMap : TileMap
var path : Array
var next_pos: Vector2
var lerp_speed = 5.0
var lerp_tolerance = 1

func begin():
    player = get_parent().get_player()
    tileMap = get_parent().get_tileMap()
    path = get_parent().get_global_path()
    next_pos = path.pop_front()
    print("BEGIN PLAYER ANIM PHASE")

func handle(delta):
    player.position = player.position.lerp(next_pos, lerp_speed * delta)
    if player.position.distance_to(next_pos) < lerp_tolerance:
        player.position = next_pos
        if len(path) == 0:
            return get_parent().GamePhase.ENEMY
        else:
            next_pos = path.pop_front()
    return get_parent().GamePhase.PLAYER_ANIM

func end():
    print("END PLAYER ANIM PHASE")

