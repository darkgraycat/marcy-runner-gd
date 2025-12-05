@abstract
class_name AttributesResource extends Resource

var values: Dictionary[String, float]

func _init() -> void:
	values = get_attributes()

@abstract
func get_attributes() -> Dictionary[String, float]
