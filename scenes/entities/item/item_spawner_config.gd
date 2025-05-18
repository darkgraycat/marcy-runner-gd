@tool
class_name ItemSpawnerConfig extends LevelChunkSpawnerConfig

@export var config_variations: Array[ItemConfig] = []


func apply_variations(item: Item) -> Item:
	if config_variations:
		item.set_config(Util.pick_random_element(config_variations))
	return item

func get_node() -> Node2D:
	return apply_variations(super.get_node())
