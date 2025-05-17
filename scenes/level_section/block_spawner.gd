@tool
class_name BlockSpawner2 extends LevelSectionSpawner

@export var config_variations: Array[BlockConfig] = []

func _ready() -> void:
	scene = load("res://scenes/entities/block/block.tscn")
	super._ready()

func _spawn() -> Block:
	var block: Block = super._spawn()
	var config: BlockConfig = Util.pick_random_element(config_variations)
	if config: block.set_config(config)
	return block
