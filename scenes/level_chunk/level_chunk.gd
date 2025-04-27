@tool
class_name LevelChunk extends Node2D

@export var configuration: LevelChunkConfig: set = set_configuration

# TODO: remove
@export var block_scene: PackedScene
# TODO: remove
@onready var blocks_root: Node2D = %BlocksRoot

func set_configuration(new_configuration: LevelChunkConfig) -> void:
	configuration = new_configuration
	if not is_node_ready(): await ready

	_clear_entities()
	# TODO: remove
	configuration.block_spawns.map(_spawn_block)

func _spawn_entity(spawn: LevelChunkSpawn) -> void:
	var entity: Node2D = spawn.scene.instantiate()
	if entity.has_method("spawn"): entity.spawn()
	entity.position = spawn.position * Global.TILE_SIZE
	add_child(entity)


func _clear_entities() -> void:
	for block: Block in blocks_root.get_children():
		block.queue_free()

# TODO: remove
func _spawn_block(block_spawn: BlockSpawn) -> void:
	var block: Block = block_scene.instantiate()
	block.set_configuration(block_spawn.configuration)
	block.position = block_spawn.position * Global.TILE_SIZE
	blocks_root.add_child(block)
