@tool
class_name BlockSpawner2 extends LevelSectionSpawner

@onready var config_variations: Array[BlockConfig] = [
	load("res://resources/blocks/block_0_00000.tres"),
	load("res://resources/blocks/block_0_00000_c.tres"),
]

func _ready() -> void:
	scene = load("res://scenes/entities/block/block.tscn")
	super._ready()

func _spawn() -> Block:
	var block: Block = super._spawn()
	var config: BlockConfig = Util.pick_random_element(config_variations)
	block.set_config(config)
	return block
