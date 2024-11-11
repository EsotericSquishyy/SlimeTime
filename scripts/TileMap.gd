extends TileMap

var tile_data = {}
var mouse_pos : Vector2i = Vector2i(0,0)

func _ready():
    var layer_ind = _get_layer_index("Ground")

    for cell in get_used_cells(layer_ind):
        tile_data[cell] = Tile.new(Consts.TileType.Ground)

    layer_ind = _get_layer_index("Water")
    for cell in get_used_cells(layer_ind):
        tile_data[cell] = Tile.new(Consts.TileType.Water)

    # var coords = tile_data.keys().map(map_to_local).map(to_global)
    # print(coords)

func _process(_delta):
    mouse_pos = _get_tile_pos(mouse_pos)

func update_tile(cell: Vector2, occupied: bool, effects: Array):
    tile_data[cell]["occupied"] = occupied
    tile_data[cell]["status_effects"] = effects

func _get_layer_index(layer_name: String) -> int:
    for i in range(get_layers_count()):
        if get_layer_name(i) == layer_name:
            return i
    return -1

func _get_tile_pos(curr: Vector2i):
    var space_state = get_world_2d().direct_space_state
    
    var query = PhysicsPointQueryParameters2D.new()
    query.collision_mask = Consts.TILE_OVERLAY_MASK
    query.position = get_global_mouse_position()
    
    var result = space_state.intersect_point(query)
    if(result.size() == 1):
        var tile_pos = get_coords_for_body_rid(result.front().rid)
        if(tile_pos in tile_data):
            return tile_pos
        
    return curr

func get_cursor_pos():
    return to_global(map_to_local(mouse_pos))
