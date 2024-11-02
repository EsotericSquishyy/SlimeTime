extends Node2D

@onready var map: TileMap

func _ready():
    position = get_map_pos()
    return


func _process(delta):
    position = get_map_pos()
    return


func _get_map_pos():

