@tool
class_name EnemySpawnerConfig extends LevelChunkSpawnerConfig

@export var config_variations: Array[EnemyConfig] = []


func apply_variations(enemy: Enemy) -> Enemy:
	if config_variations:
		enemy.set_config(Util.pick_random_element(config_variations))
	return enemy

func get_node() -> Node2D:
	return apply_variations(super.get_node())
