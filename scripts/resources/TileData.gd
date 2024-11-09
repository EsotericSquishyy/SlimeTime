extends Resource

class_name Tile

const TileType = Consts.TileType
var _occupants: Array[Node2D]
var _slimed: bool
var _type: TileType

func _init(type: TileType = TileType.Ground, occupants: Array[Node2D] = [], slimed: bool = false):
    self._type      = type
    self._occupants = occupants
    self._slimed    = slimed

