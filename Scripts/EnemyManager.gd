extends Node

const ENEMY_PREFAB = preload("res://Nodes/Enemy.tscn")

@export var enemy_datas : Dictionary
var enemies = []

func _ready():
    # Spawns in enemies based on EnemyData provided
    for key in enemy_datas.keys():
        var value = enemy_datas[key]
        var e = ENEMY_PREFAB.instantiate()
        add_child(e)
        e.position = key
        e.init(value)
        enemies.append(e)
