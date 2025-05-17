@tool
class_name LevelChunkSpawner extends Node2D

@export var spawner_config: LevelChunkSpawnerConfig

func _ready() -> void:
	if not spawner_config is LevelChunkSpawnerConfig:
		push_error("scene is not set up")

func spawn() -> Node2D:
	var node: Node2D = spawner_config.get_node()
	if not node is Node2D:
		push_error("cannot get node")
		return null
	add_child(node)
	return node
