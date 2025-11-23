@tool
class_name ParallaxResource extends Resource

@export_range(0, 24) var total_rows: int = 0: set = set_total_rows
@export_group("Rows configuration")
@export var colors: Array[Color] = []
@export var frames: Array[int] = []
@export_range(0.0, 1.0, 0.01) var offsets: Array[float] = []


func set_total_rows(value: int) -> void:
	total_rows = value
	colors.resize(value)
	frames.resize(value)
	offsets.resize(value)
	notify_property_list_changed()

