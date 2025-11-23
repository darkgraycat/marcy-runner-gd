@tool
extends Node

signal notification(message: String, channel: int)


var time: float:
	get: return Time.get_unix_time_from_system()

## DEBUG #######################################################################


func log(msg: String, ...rest: Array) -> void:
	var time := float(Time.get_ticks_msec())
	prints("%8.3f│%s" % [time / 1000, msg], rest)


func notify(message: String, channel: int = 0) -> void:
	notification.emit(message, channel)

## FILE MANAGEMENT #############################################################

func load_as_text(path: String) -> String:
	print("Loading text: %s" % path)
	assert(FileAccess.file_exists(path), "File is not exist: %s" % path)
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var content: String = file.get_as_text()
	file.close()
	return content


func load_as_json(path: String) -> Dictionary:
	print("Loading json: %s" % path)
	assert(FileAccess.file_exists(path), "File is not exist: %s" % path)
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var json: JSON = JSON.new()
	json.parse(file.get_as_text())
	return json.data


func save_as_text(path: String, data: String) -> void:
	print("Saving text: %s" % path)
	assert(FileAccess.file_exists(path), "File is not exist: %s" % path)
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data)
	file.close()


func load_resource(path: String) -> Resource:
	print("Loading resource: %s" % path)
	assert(ResourceLoader.exists(path), "Resource is not exist: %s" % path)
	var resource: Resource = load(path)
	return resource

## CALCULATIONS ################################################################

func get_recti_coords(rect: Rect2i) -> Array[Vector2i]:
	var coords: Array[Vector2i] = []
	for x in rect.size.x:
		for y in rect.size.y:
			coords.append(Vector2i(rect.position.x + x, rect.position.y + y))
	return coords

## UTILS FOR NODES #############################################################

func cast_type(value: Variant, type: int) -> Variant:
	match type:
		TYPE_INT: return int(value)
		TYPE_FLOAT: return float(value)
		TYPE_STRING: return str(value)
		TYPE_VECTOR2: return Vector2(value)
		TYPE_VECTOR3: return Vector3(value)
		_: return value


func cast_array(target: Array, value: Array, type: int) -> void:
	for i: int in value.size():
		var v: Variant = cast_type(value[i], type)
		if i < target.size(): target[i] = v
		else: target.append(v)


func snap_angle(angle: float, step_deg: float) -> float:
	var step_rad := deg_to_rad(step_deg)
	return round(angle / step_rad) * step_rad


func find_nodes_of_type(node: Node, type: Variant) -> Array[Variant]:
	return node.get_children().filter(
		func(n: Node) -> bool:
			return is_instance_of(n, type)
	)


func filter_nodes(nodes: Array[Node], type: Variant) -> Array[Variant]:
	return nodes.filter(
		func(n: Node) -> bool: return is_instance_of(n, type)
	)


func sleep(delay: float) -> void:
	await get_tree().create_timer(delay).timeout


## VALIDATION AND ERROR HANDLING ###############################################

func generate_configuration_warnings(...bool_message_pairs: Array) -> PackedStringArray:
	var warnings: PackedStringArray = []
	for pair: Array in bool_message_pairs:
		if pair[0]: warnings.append(pair[1])
	return warnings


func validate_error_pairs(node: Node, ...bool_string_pairs: Array) -> bool:
	return bool_string_pairs.all(
		func(pair: Array) -> bool:
			if pair[0]: push_error(node, pair[1])
			return !pair[0]
	)


## Validator utility for fluent condition checking on a Node. <br>
## Example: Utils.validate(self).check(!parent, "Parent missing").check(x < 0, "x negative")
func validate(caused_by: Node) -> Validator:
	return Validator.new(caused_by)


class Validator:
	var caused_by: Node
	var is_valid := true
	func _init(node: Node) -> void: caused_by = node
	func check(cond: bool, error: String) -> Validator:
		if cond:
			is_valid = false
			push_error(caused_by, error)
		return self
