extends TileMap

# Used for raycasting to get hovered tile
const _TILEMAP_COLLISION_LAYER = 1 << 7

# Used for offsetting cursor for half tiles
const _CURSOR_LOCAL_HALF_TILE_OFFSET = Vector2(0, 8)

# Overlay layer and tileset source names
const _TILEMAP_LAYER_SLIME = "Slime"
const _TILEMAP_LAYER_OVERLAY = "Overlay"
const _TILESET_SOURCE_OVERLAY = "Overlay"
const _TILESET_SOURCE_OVERLAY_HALF = "Overlay_Half"

# Overlay vars
var over_source_id = -1
var over_half_source_id = -1
var over_ind = -1
var slime_ind = -1
var _over_hidden = false

# TileData access information
var _tile_data = {}
var _cursor_pos : Vector2i = Vector2i(0,0)

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

func init():
    over_source_id = get_tileset_source_id(_TILESET_SOURCE_OVERLAY)
    over_half_source_id = get_tileset_source_id(_TILESET_SOURCE_OVERLAY_HALF)

    over_ind = get_layer_index(_TILEMAP_LAYER_OVERLAY)
    slime_ind = get_layer_index(_TILEMAP_LAYER_SLIME)

    for i in range(get_layers_count()): # Overlay and Slime layers should not have any cells initially
        for cell in get_used_cells(i):
            _tile_data[cell] = TileVals.new(self, cell, i)

    for cell in _tile_data: # Must update overlay layers after, not during prior iteration
        _tile_data[cell].update_overlay()

    toggle_overlay()

func get_tile_pos_at(pos: Vector2, curr: Vector2i):
    ## Raycast
    var space_state = get_world_2d().direct_space_state
    var query = PhysicsPointQueryParameters2D.new()
    query.collision_mask = _TILEMAP_COLLISION_LAYER
    query.position = pos
    var results = space_state.intersect_point(query)

    if(results.size() > 0):
        var temp_pos = get_coords_for_body_rid(results.front().rid)

        for result in results:
            var tile_pos = get_coords_for_body_rid(result.rid)

            if tile_pos.x > temp_pos.x || tile_pos.y > temp_pos.y:
                temp_pos = tile_pos

        return temp_pos

    return curr

func get_tile_pos(curr: Vector2i):
    return get_tile_pos_at(get_global_mouse_position(), curr)

func update_cursor_pos():
    _cursor_pos = get_tile_pos(_cursor_pos)

func get_cursor_pos():
    return _cursor_pos

func get_cursor_pos_global():
    if(_tile_data[_cursor_pos]._is_half_tile):
        return to_global(map_to_local(_cursor_pos) + _CURSOR_LOCAL_HALF_TILE_OFFSET)
    else:
        return to_global(map_to_local(_cursor_pos))

func toggle_overlay():
    _over_hidden = !_over_hidden

    if _over_hidden:
        set_layer_modulate(over_ind, Color(1,1,1,0))
    else:
        set_layer_modulate(over_ind, Color(1,1,1,1))

func toggle_selected_overlay(curr: Vector2i):
    _tile_data[curr].toggle_selected_overlay()
    
func toggle_slimed(curr: Vector2i):
    _tile_data[curr].toggle_slimed()
    
func is_slimed(curr: Vector2i):
    return _tile_data[curr].is_slimed()
 
func is_crossable(curr: Vector2i):
    return _tile_data[curr].is_crossable()
    
func get_cost(curr: Vector2i):
    return _tile_data[curr].get_cost()

func get_unit(curr: Vector2i):
    return _tile_data[curr].get_unit()
    
func set_unit(curr: Vector2i, unit: Node2D):
    _tile_data[curr].set_unit(unit)

func is_adjacent(vec1: Vector2i, vec2: Vector2i):
    return abs(vec1.x - vec2.x) + abs(vec1.y - vec2.y) == 1

func map_to_global(curr: Vector2i):
    if(_tile_data[curr]._is_half_tile):
        return to_global(map_to_local(curr) + _CURSOR_LOCAL_HALF_TILE_OFFSET)
    else:
        return to_global(map_to_local(curr))
