@tool
extends Node

signal notification(message: String, channel: int)

func notify(message: String, channel: int = 0) -> void:
	notification.emit(message, channel)

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

func pick_random_element(array: Array) -> Variant:
	if array.is_empty(): return null
	return array[randi() % array.size()]
