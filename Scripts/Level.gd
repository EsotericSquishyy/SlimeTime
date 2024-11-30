extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
    $TileMap.init()
    $Player.init($TileMap)
    $GameManager.init($TileMap, $Player, $Cursor, $EnemyManager)
    $Label.init($Player)
