@tool
class_name LevelSectionSpawner extends Node2D

@export var scene: PackedScene

func _ready() -> void:
	if not scene:
		push_error("scene must be defined")
		return
	_spawn()

func _spawn() -> Node2D:
	var instance: Node2D = scene.instantiate()
	add_child(instance)
	return instance
