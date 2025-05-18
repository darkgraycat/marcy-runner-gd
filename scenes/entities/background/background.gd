@tool
class_name Background extends Node2D

@export var config: BackgroundConfig: set = set_config

@onready var sky: ColorRect = %Sky
@onready var sun: Sprite2D = %Sun
@onready var rows_root: Node2D = %BackgroundRowsRoot

var primary_color: Color:
	get():
		return sky.modulate.darkened(0.1)

func set_config(new_configuration: BackgroundConfig) -> void:
	config = new_configuration
	if not config: return printerr("No config")
	if not is_node_ready(): await ready

	sky.modulate = config.sky_color
	sun.modulate = config.sun_color
	sun.frame = config.sun_frame
	sun.position.y = config.sun_offset * Global.VIEWPORT_HEIGHT

	for row_idx: int in rows_root.get_child_count():
		var row: BackgroundRow = rows_root.get_child(row_idx)
		row.color = config["row%d_color" % row_idx]
		row.frame = config["row%d_frame" % row_idx]
		row.position.y = config["row%d_offset" % row_idx] * Global.VIEWPORT_HEIGHT
