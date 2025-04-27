@tool
class_name Block extends Node2D

@export var configuration: BlockConfig: set = set_configuration
@export var connection_level: int = -1: set = set_connection_level

@onready var head: Sprite2D = %BlockHead
@onready var decor: Sprite2D = %BlockDecor
@onready var connection: Sprite2D = %BlockConnection
@onready var segments_root: Node2D = %BlockSegmentsRoot

func set_configuration(new_configuration: BlockConfig) -> void:
	configuration = new_configuration
	if not configuration: return printerr("No configuration")
	if not is_node_ready(): await ready

	head.visible = configuration.head_frame >= 0
	if head.visible: head.frame = configuration.head_frame

	decor.visible = configuration.decor_frame >= 0
	if decor.visible: decor.frame = configuration.decor_frame

	connection.visible = configuration.connection_frame >= 0
	if connection.visible:
		connection.frame = configuration.connection_frame
		connection_level = configuration.connection_level

	for segment_idx: int in segments_root.get_child_count():
		var segment: Sprite2D = segments_root.get_child(segment_idx)
		segment.frame = configuration["segment%d_frame" % segment_idx]

func set_connection_level(new_connection_level: int) -> void:
	connection.position.y = new_connection_level * Global.TILE_SIZE

func spawn(spawner: BlockSpawner) -> void:
	if spawner.configuration_variations.is_empty(): return
	configuration = Util.pick_random_element(spawner.configuration_variations)
