@tool
class_name ResourceVisualizer extends Node

const INTERVAL = 0.5

@export_group("Options")
@export var visualize: bool = false: set = set_visualize
@export var visualize_seconds: float = 60.0
@export_group("Target")
@export var target: Node
@export var method_name: String
@export var resource: Resource

func set_visualize(new_visualize: bool) -> void:
	visualize = new_visualize
	if visualize:
		_update()

func _update() -> void:
	if not visualize: return

	if visualize_seconds <= 0:
		visualize = false

	if Engine.is_editor_hint():
		assert(target, "No target defined")
		assert(target.has_method(method_name), "No method found")
		assert(resource, "No resource defined")
		prints("Visualize resource", resource, "for", target)
		target.call(method_name, resource)

	await get_tree().create_timer(INTERVAL).timeout
	visualize_seconds -= INTERVAL
	_update()
