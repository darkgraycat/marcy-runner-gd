@tool
class_name JsonResource extends Resource

@export var json: JSON


func init() -> JsonResource:
	if json:
		_build(json.data)
	return self


func parse(prop_name: StringName, value: Variant, type: int) -> void:
	var current: Variant = self[prop_name]
	if current is Array and value is Array: Utils.cast_array(current, value, type)
	else: self[prop_name] = Utils.cast_type(value, type)


func save(data: Dictionary) -> void:
	Utils.save_as_text(json.resource_path, JSON.stringify(data))


func _build(_data: Dictionary) -> void:
	assert(false, "_build() must be overridden by subclass")
