extends Phase

enum PlayerState {
    SELECTED,
    UNSELECTED
}

var _state : PlayerState = PlayerState.UNSELECTED
var _tileMap : TileMap
var _path : Array[Vector2i]
var _player : Node2D
var _player_pos : Vector2i

func begin():
    _tileMap = get_parent().get_tileMap()
    _player = get_parent().get_player()
    _player_pos = _tileMap.get_tile_pos_at(_player.global_position, _player.position)
    _path = [_player_pos]
    _tileMap.toggle_selected_overlay(_player_pos)
    print("BEGIN PLAYER PHASE")

func handle(_delta):
    match _state:
        PlayerState.UNSELECTED:
            return _handle_unselected()
        PlayerState.SELECTED:
            return _handle_selected()

func end():
    print("END PLAYER PHASE")

func _toggle_selected():
    _tileMap.toggle_overlay()
    match _state:
        PlayerState.UNSELECTED:
            _state = PlayerState.SELECTED
        PlayerState.SELECTED:
            _state = PlayerState.UNSELECTED

func _handle_unselected():
    if Input.is_action_just_pressed("mouse_left") and _tileMap.get_cursor_pos() == _player_pos:
        _toggle_selected()

    return get_parent().GamePhase.PLAYER

func _handle_selected():
    var tile_pos = _tileMap.get_cursor_pos()

    var index = _path.find(tile_pos)
    if index == -1:
        if _tileMap.is_crossable(tile_pos) and _tileMap.is_adjacent(tile_pos, _path[-1]):
            _tileMap.toggle_selected_overlay(tile_pos)
            _path.append(tile_pos)
    else:
        for i in range(index + 1, _path.size()):
            _tileMap.toggle_selected_overlay(_path[i])
            
        _path = _path.slice(0, index + 1)

    if(Input.is_action_just_pressed("mouse_right")):
        _toggle_selected()
        
        for i in range(1, _path.size()):
            _tileMap.toggle_selected_overlay(_path[i])
            
        _path = [_player_pos]
    elif Input.is_action_just_pressed("mouse_left"):
        _toggle_selected()
        
        if tile_pos == _player_pos:
            _path = [_player_pos]
        else:
            for i in range(0, _path.size()):
                _tileMap.toggle_selected_overlay(_path[i])
                
            _path.pop_front()
            get_parent().set_path(_path)
            
            return get_parent().GamePhase.PLAYER_ANIM

    return get_parent().GamePhase.PLAYER
