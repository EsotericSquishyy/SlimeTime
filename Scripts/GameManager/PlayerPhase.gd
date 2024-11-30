extends Phase

enum PlayerState {
    SELECTED,
    UNSELECTED
}

var state : PlayerState = PlayerState.UNSELECTED
var tileMap : TileMap
var path : Array[Vector2i]
var player : Node2D
var player_pos : Vector2i

func begin():
    tileMap = get_parent().get_tileMap()
    player = get_parent().get_player()
    player_pos = tileMap.get_tile_pos(player.position)
    path = [player_pos]
    print("BEGIN PLAYER PHASE")


func handle(_delta):
    match state:
        PlayerState.UNSELECTED:
            return _handle_unselected()
        PlayerState.SELECTED:
            return _handle_selected()

func end():
    print("END PLAYER PHASE")


func _toggle_selected():
    tileMap.toggle_overlay()
    match state:
        PlayerState.UNSELECTED:
            state = PlayerState.SELECTED
        PlayerState.SELECTED:
            state = PlayerState.UNSELECTED


func _handle_unselected():
    if Input.is_action_just_pressed("mouse_left") and tileMap.cursor_pos == player_pos:
        _toggle_selected()
    return get_parent().GamePhase.PLAYER


func _handle_selected():
    var tile_pos = tileMap.cursor_pos

    var index = path.find(tile_pos)
    if index == -1:
        if tileMap.is_crossable(tile_pos):
            if tileMap.is_adjacent(tile_pos, path[-1]):
                tileMap.toggle_selected_overlay(tile_pos)
                path.append(tile_pos)
    else:
        for i in range(index + 1, path.size()):
            tileMap.toggle_selected_overlay(path[i])
        path = path.slice(0, index + 1)

    if Input.is_action_just_pressed("mouse_left"):
        _toggle_selected()
        if tile_pos == player_pos:
            path = [player_pos]
        else:
            get_parent().set_path(path)
            return get_parent().GamePhase.PLAYER_ANIM

    return get_parent().GamePhase.PLAYER
