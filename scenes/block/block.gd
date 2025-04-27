@tool
class_name Block extends Node2D

# TODO: remove
signal activated(block: Block)
signal deactivated(block: Block)

@export var configuration: BlockConfig: set = set_configuration
@export var connection_level: int = -1

@onready var head: Sprite2D = %BlockHead
@onready var decor: Sprite2D = %BlockDecor
@onready var connection: Sprite2D = %BlockConnection
@onready var segments_root: Node2D = %BlockSegmentsRoot

func set_configuration(new_configuration: BlockConfig) -> void:
	configuration = new_configuration
	if not is_node_ready(): await ready

	head.visible = configuration.head_frame >= 0
	if head.visible: head.frame = configuration.head_frame

	decor.visible = configuration.decor_frame >= 0
	if decor.visible: decor.frame = configuration.decor_frame

	connection.visible = configuration.connection_frame >= 0
	if connection.visible: connection.frame = configuration.connection_frame

	for segment_idx: int in segments_root.get_child_count():
		var segment: Sprite2D = segments_root.get_child(segment_idx)
		segment.frame = configuration["segment%d_frame" % segment_idx]

func set_connection_level(new_connection_level: int) -> void:
	connection.position.y = new_connection_level * Global.TILE_SIZE

# TODO: remove
func connect_with_previous(previous_block: Block) -> void:
	var offset: float = max(global_position.y - previous_block.global_position.y, 0)
	connection.position.y = offset

# TODO: remove
func _on_screen_entered() -> void:
	activated.emit(self)

# TODO: remove
func _on_screen_exited() -> void:
	deactivated.emit(self)
