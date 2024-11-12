extends Resource

class_name TileVals

const TileType = Consts.TileType

var _tileMap: TileMap
var _pos: Vector2i
var _layer: int
var _slimed: bool
var _crossable: bool

# var _occupant: Node2D

func _init(tileMap: TileMap, pos: Vector2i, layer: int):
    _tileMap   = tileMap
    _pos       = pos
    _layer     = layer

    var tile_data = _tileMap.get_cell_tile_data(layer, self._pos)
    init_slime(tile_data)
    init_overlay(tile_data)



func init_slime(tile_data: TileData):
    _slimed = tile_data.get_custom_data("Slimed")
    var slime_ind = _tileMap.get_layer_index("Slime")
    if _slimed:
        _tileMap.set_cell(slime_ind, _pos, 3, Vector2i(3,0))



func init_overlay(tile_data: TileData):
    _crossable = tile_data.get_custom_data("Crossable")
    var over_ind = _tileMap.get_layer_index("Overlay")
    if _crossable:
        _tileMap.set_cell(over_ind, _pos, 3, Vector2i(2, 0))
    else:
        _tileMap.set_cell(over_ind, _pos, 3, Vector2i(1, 0))



func toggle_slime():
    var slime_ind = _tileMap.get_layer_index("Slime")
    if _slimed:
        _slimed = false
        _tileMap.set_cell(slime_ind, _pos, -1)
    else:
        _slimed = true
        _tileMap.set_cell(slime_ind, _pos, 3, Vector2i(3,0))
