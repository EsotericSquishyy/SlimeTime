extends Resource

class_name Tile

var _occupants: Array[Node2D] = []
var _slimed: bool = false

func _init(occupants: Array[Node2D] = [], slimed: bool = false):
    self._occupants = occupants
    self._slimed = slimed

