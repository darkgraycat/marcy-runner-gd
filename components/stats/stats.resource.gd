@abstract class_name StatsResource extends Resource

var _attrs: Dictionary[String, float]

@abstract
func get_attributes() -> Dictionary[String, float]

func _init() -> void:
	_attrs = get_attributes()
