@tool
class_name Background extends Node2D

@export var configuration: BackgroundConfig: set = set_configuration

@onready var sky: ColorRect = %Sky
@onready var sun: Sprite2D = %Sun
@onready var rows_root: Node2D = %BackgroundRowsRoot

func set_configuration(new_configuration: BackgroundConfig) -> void:
	configuration = new_configuration
	if not configuration: return printerr("No configuration")
	if not is_node_ready(): await ready

	sky.modulate = configuration.sky_color
	sun.modulate = configuration.sun_color
	sun.frame = configuration.sun_frame
	sun.position.y = configuration.sun_offset * Global.VIEWPORT_HEIGHT

	for row_idx: int in rows_root.get_child_count():
		var row: BackgroundRow = rows_root.get_child(row_idx)
		row.color = configuration["row%d_color" % row_idx]
		row.frame = configuration["row%d_frame" % row_idx]
		row.position.y = configuration["row%d_offset" % row_idx] * Global.VIEWPORT_HEIGHT
