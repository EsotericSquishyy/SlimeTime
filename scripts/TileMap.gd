extends TileMap

var tile_data = {}
var cursor_pos : Vector2i = Vector2i(0,0)
var over_hidden = false

const TileType = Consts.TileType

func _ready():
    var layer_ind = get_layer_index("Ground")
    for cell in get_used_cells(layer_ind):
        tile_data[cell] = TileVals.new(self, cell, layer_ind)

    layer_ind = get_layer_index("Water")
    for cell in get_used_cells(layer_ind):
        tile_data[cell] = TileVals.new(self, cell, layer_ind)

    toggle_overlay()



func _process(_delta):
    cursor_pos = _get_tile_pos(cursor_pos)



func get_layer_index(layer_name: String) -> int:
    for i in range(get_layers_count()):
        if get_layer_name(i) == layer_name:
            return i
    return -1



func _get_tile_pos(curr: Vector2i):
    var space_state = get_world_2d().direct_space_state
    var query = PhysicsPointQueryParameters2D.new()
    query.collision_mask = Consts.TILE_OVERLAY_MASK
    query.position = get_global_mouse_position()
    var results = space_state.intersect_point(query)

    var max_layer = -1
    var temp_pos = curr
    for result in results:
        var tile_pos = get_coords_for_body_rid(result.rid)
        var tile_layer = get_layer_for_body_rid(result.rid) 

        if tile_layer > max_layer:
            temp_pos = tile_pos
            max_layer = tile_layer

    return temp_pos

    ### Alternate version [better :)]
    # var tile_pos = local_to_map(get_local_mouse_position())
    # if tile_pos in tile_data:
    #     return tile_pos
    # return curr



func get_cursor_pos():
    return to_global(map_to_local(cursor_pos))



func toggle_overlay():
    var over_ind = get_layer_index("Overlay")
    if over_hidden:
        set_layer_modulate(over_ind, Color(1,1,1,1))
        over_hidden = false
    else:
        set_layer_modulate(over_ind, Color(1,1,1,0))
        over_hidden = true



func _input(event):
    if Input.is_action_just_pressed("ui_accept"):
        toggle_overlay()

    if event is InputEventMouseButton and event.pressed:
            tile_data[cursor_pos].toggle_slime()
