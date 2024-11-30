extends Label

var _player : Node2D

func init(player : Node2D):
    _player = player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    text = str(_player.get_slime_count())
