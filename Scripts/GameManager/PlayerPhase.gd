extends Phase

enum PlayerState {
    SELECTED,
    UNSELECTED
}

var state : PlayerState = PlayerState.UNSELECTED
var path = []
var tileMap : TileMap
var player : Node2D
var player_pos : Vector2i

func begin():
    tileMap = get_parent().tileMap
    player = get_parent().player
    player_pos = tileMap.get_tile_pos(player.position)
    path = [player_pos]
    print("BEGIN PLAYER PHASE")


func handle(_delta):
    match state:
        PlayerState.UNSELECTED:
            _handle_unselected()
        PlayerState.SELECTED:
            _handle_selected()

    return get_parent().GamePhase.PLAYER

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
    var mouse_pos = get_viewport().get_mouse_position()
    var tile_pos = tileMap.get_tile_pos(mouse_pos)

    if Input.is_action_just_pressed("mouse_left") and tile_pos == player_pos:
        _toggle_selected()
    return


func _handle_selected():
    var mouse_pos = get_viewport().get_mouse_position()
    var tile_pos = tileMap.get_tile_pos(mouse_pos)

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
            end()

    return
