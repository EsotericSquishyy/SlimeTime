extends TileMap

var tile_data = {}
var cursor_pos : Vector2i = Vector2i(0,0)

# Overlay variables
var over_source_id = -1
var over_ind = -1
var slime_ind = -1
var over_hidden = false

# const TileType = Consts.TileType

func get_tileset_source_id(tileset_source_name: String) -> int:
    for i in range(tile_set.get_source_count()):
        if(tile_set.get_source(tile_set.get_source_id(i)).resource_name == tileset_source_name):
            return tile_set.get_source_id(i)
            
    return -1
    
func get_layer_index(layer_name: String) -> int:
    for i in range(get_layers_count()):
        if get_layer_name(i) == layer_name:
            return i
            
    return -1

func _ready():
    over_source_id = get_tileset_source_id(Consts.TILESET_SOURCE_OVERLAY)
    
    over_ind = get_layer_index(Consts.TILEMAP_LAYER_OVERLAY)
    slime_ind = get_layer_index(Consts.TILEMAP_LAYER_SLIME)
    
    for i in range(get_layers_count()): # Overlay and Slime layers should not have any cells initially
        for cell in get_used_cells(i):
            tile_data[cell] = TileVals.new(self, cell, i)

    for cell in tile_data: # Must update overlay layers after, not during prior iteration
        tile_data[cell].update_overlay()

    toggle_overlay()
    
func _process(_delta):
    cursor_pos = _get_tile_pos(cursor_pos)

func _get_tile_pos(curr: Vector2i):
    # Raycast
    var space_state = get_world_2d().direct_space_state
    var query = PhysicsPointQueryParameters2D.new()
    query.collision_mask = Consts.TILEMAP_COLLISION_LAYER
    query.position = get_global_mouse_position()
    var results = space_state.intersect_point(query)

    # Search results for highest layer tile
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
    ###

func get_cursor_pos():
    return to_global(map_to_local(cursor_pos))
    
func toggle_overlay():     
    over_hidden = !over_hidden
    
    if over_hidden:
        set_layer_modulate(over_ind, Color(1,1,1,0))
    else:
        set_layer_modulate(over_ind, Color(1,1,1,1))

func _input(event):
    if Input.is_action_just_pressed("ui_accept"):
        toggle_overlay()

    if event is InputEventMouseButton and event.pressed:
        tile_data[cursor_pos].toggle_slime()
