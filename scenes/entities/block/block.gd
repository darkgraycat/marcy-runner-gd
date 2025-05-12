@tool
class_name Block extends Node2D

@export var config: BlockConfig: set = set_config
@export var connection_level: int = -1: set = set_connection_level

@onready var head: Sprite2D = %BlockHead
@onready var decor: Sprite2D = %BlockDecor
@onready var connection: Sprite2D = %BlockConnection
@onready var segments_root: Node2D = %BlockSegmentsRoot

func set_config(new_config: BlockConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready

	set_head(config.head_frame)
	set_decor(config.decor_frame)
	set_connection(config.connection_frame)
	set_connection_level(config.connection_level)
	for idx: int in segments_root.get_child_count():
		set_segment(config["segment%d_frame" % idx], idx)

func set_connection_level(new_connection_level: int) -> void:
	connection.position.y = new_connection_level * Global.TILE_SIZE

func set_head(frame: int) -> void:
	head.visible = frame >= 0
	if head.visible: head.frame = frame

func set_decor(frame: int) -> void:
	decor.visible = frame >= 0
	if decor.visible: decor.frame = frame

func set_connection(frame: int) -> void:
	connection.visible = frame >= 0
	if connection.visible: connection.frame = frame

func set_segment(frame: int, idx: int) -> void:
	var segment: Sprite2D = segments_root.get_child(idx)
	segment.frame = frame
