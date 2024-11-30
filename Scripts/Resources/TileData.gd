extends Resource

class_name TileVals

# Overlay tileset source atlas coords
const _TILESET_OVERLAY_UNCROSSABLE = Vector2i(1, 0)
const _TILESET_OVERLAY_CROSSABLE = Vector2i(2, 0)
const _TILESET_OVERLAY_SLIMED = Vector2i(3, 0)
const _TILESET_OVERLAY_SLIMED_TRANSPARENT = Vector2i(4, 0)
const _TILESET_OVERLAY_PATH = Vector2i(5, 0)

# Custom data layer names
const _TILEDATA_SLIMED = "Slimed"
const _TILEDATA_CROSSABLE = "Crossable"
const _TILEDATA_IS_HALF_TILE = "Is_Half_Tile"
const _TILEDATA_COST = "Cost"

# Vars for editing tilemap
var _tileMap : TileMap
var _pos : Vector2i
var _over_source_id : int

# Tile data vars
var _selected : bool
var _slimed : bool
var _crossable : bool
var _is_half_tile : bool
var _cost : int

var _unit : Node2D

func _init(tileMap : TileMap, pos : Vector2i, layer : int):
    _tileMap   = tileMap
    _pos       = pos

    var tile_data = _tileMap.get_cell_tile_data(layer, _pos)
    _selected = false
    _slimed = tile_data.get_custom_data(_TILEDATA_SLIMED)
    _crossable = tile_data.get_custom_data(_TILEDATA_CROSSABLE)
    _is_half_tile = tile_data.get_custom_data(_TILEDATA_IS_HALF_TILE)
    _cost = tile_data.get_custom_data(_TILEDATA_COST)

    if(_is_half_tile):
        _over_source_id = _tileMap.over_half_source_id
    else:
        _over_source_id = _tileMap.over_source_id

func update_overlay():
    if _crossable:
        _tileMap.set_cell(_tileMap.over_ind, _pos, _over_source_id, _TILESET_OVERLAY_CROSSABLE)
    else:
        _tileMap.set_cell(_tileMap.over_ind, _pos, _over_source_id, _TILESET_OVERLAY_UNCROSSABLE)

    if _slimed:
        _tileMap.set_cell(_tileMap.over_ind, _pos, _over_source_id, _TILESET_OVERLAY_SLIMED_TRANSPARENT)
        _tileMap.set_cell(_tileMap.slime_ind, _pos, _over_source_id, _TILESET_OVERLAY_SLIMED)
    else:
        _tileMap.set_cell(_tileMap.slime_ind, _pos, -1)

    if _selected:
        _tileMap.set_cell(_tileMap.over_ind, _pos, _over_source_id, _TILESET_OVERLAY_PATH)

func toggle_selected_overlay():
    _selected = !_selected
    update_overlay()

func toggle_slimed():
    _slimed = !_slimed
    update_overlay()

func is_slimed():
    return _slimed
    
func is_crossable():
    return _crossable

func get_cost():
    return _cost

func get_unit():
    return _unit

func set_unit(unit : Node2D):
    _unit = unit
