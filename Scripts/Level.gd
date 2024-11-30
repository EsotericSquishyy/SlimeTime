extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
    $TileMap.init()
    $GameManager.init($TileMap, $Player, $Cursor, $EnemyManager)
