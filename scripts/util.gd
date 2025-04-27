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

func load_resource(path: String) -> Resource:
	print("Loading resource: %s" % path)
	assert(ResourceLoader.exists(path), "Resource is not exist: %s" % path)
	var resource: Resource = load(path)
	return resource

func pick_random_element(array: Array) -> Variant:
	if array.is_empty(): return null
	return array[randi() % array.size()]
