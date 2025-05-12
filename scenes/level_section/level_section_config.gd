@tool
class_name LevelSectionConfig extends JsonResource

var left_level: float = 0.0
var right_level: float = 0.0
var spawners: Array[SpawnersItem] = []

func _build(data: Dictionary) -> void:
	parse("left_level", data.left_level, TYPE_FLOAT)
	parse("right_level", data.right_level, TYPE_FLOAT)
	parse("spawners", data.spawners, TYPE_OBJECT)

class SpawnersItem:
	var script_path: String
	var name: String
	var position_x: float
	var position_y: float
