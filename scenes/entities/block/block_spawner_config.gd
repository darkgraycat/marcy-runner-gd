@tool
class_name BlockSpawnerConfig extends LevelChunkSpawnerConfig

@export var config_variations: Array[BlockConfig] = []


func apply_variations(block: Block) -> Block:
	if config_variations:
		block.set_config(Util.pick_random_element(config_variations))
	return block

func get_node() -> Node2D:
	return apply_variations(super.get_node())
