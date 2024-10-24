extends TileMap

var tile_data = {}

func _ready():
    var layer_ind = get_layer_index("Ground")
    for cell in get_used_cells(layer_ind):
        tile_data[cell] = Tile.new()
    # var coords = tile_data.keys().map(map_to_local).map(to_global)
    # print(coords)

func update_tile(cell: Vector2, occupied: bool, effects: Array):
    tile_data[cell]["occupied"] = occupied
    tile_data[cell]["status_effects"] = effects

func get_layer_index(layer_name: String) -> int:
    for i in range(get_layers_count()):
        if get_layer_name(i) == layer_name:
            return i
    return -1

func _input(event):
    if event is InputEventMouseButton and event.pressed:
        var mouse_position = event.position
        var cell_position = local_to_map(to_local(mouse_position))
        print("Cell clicked at local coordinates: ", cell_position)
