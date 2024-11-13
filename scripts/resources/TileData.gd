extends Resource

class_name TileVals

# const TileType = Consts.TileType

var _tileMap: TileMap
var _pos: Vector2i

var _over_source_id: int

# var _layer: int

var _slimed: bool
var _crossable: bool
var _is_half_tile: bool

# var _occupant: Node2D

func _init(tileMap: TileMap, pos: Vector2i, layer: int):
    _tileMap   = tileMap
    _pos       = pos

    var tile_data = _tileMap.get_cell_tile_data(layer, _pos)
    _crossable = tile_data.get_custom_data(Consts.TILEDATA_CROSSABLE)
    _slimed = tile_data.get_custom_data(Consts.TILEDATA_SLIMED)
    _is_half_tile = tile_data.get_custom_data(Consts.TILEDATA_IS_HALF_TILE)
    
    if(_is_half_tile):
        _over_source_id = _tileMap.over_half_source_id
    else:
        _over_source_id = _tileMap.over_source_id

func update_overlay():
    if _crossable:
        _tileMap.set_cell(_tileMap.over_ind, _pos, _over_source_id, Consts.TILESET_OVERLAY_CROSSABLE)
    else:
        _tileMap.set_cell(_tileMap.over_ind, _pos, _over_source_id, Consts.TILESET_OVERLAY_UNCROSSABLE)

    if _slimed:
        _tileMap.set_cell(_tileMap.over_ind, _pos, _over_source_id, Consts.TILESET_OVERLAY_SLIMED_TRANSPARENT)
        _tileMap.set_cell(_tileMap.slime_ind, _pos, _over_source_id, Consts.TILESET_OVERLAY_SLIMED)
    else:
        _tileMap.set_cell(_tileMap.slime_ind, _pos, -1)

func toggle_slime(): # Temp function for testing
    _slimed = !_slimed
    update_overlay()
