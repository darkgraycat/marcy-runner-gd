@tool
class_name LevelChunkSpawnerConfig extends Resource

@export var scene: PackedScene

func get_node() -> Node2D:
	if not scene:
		push_error("scene is not defined")
		return null
	return scene.instantiate()
