extends Node

var _tileMap : TileMap
var _player : Node2D

func init(tileMap : TileMap, player : Node2D):
    _tileMap = tileMap
    _player = player
    
    for enemy in get_children():
        enemy.init()
    
func get_tileMap():
    return _tileMap

func get_player():
    return _player
