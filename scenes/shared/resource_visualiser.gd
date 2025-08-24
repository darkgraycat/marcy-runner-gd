@tool
class_name ResourceVisualizer extends Node

const INTERVAL: float = 0.5

@export_group("Options")
@export var visualize: bool = false: set = set_visualize
@export var visualize_seconds: float = 60.0
@export_group("Target")
@export var target: Node
@export var method_name: String
@export var resource: Resource

var _visualize_seconds_left: float = visualize_seconds

func set_visualize(new_visualize: bool) -> void:
	visualize = new_visualize
	if visualize:
		_visualize_seconds_left = visualize_seconds
		_update()

func _update() -> void:
	if not visualize: return

	if _visualize_seconds_left <= 0:
		visualize = false

	if Engine.is_editor_hint():
		assert(target, "No target defined")
		assert(target.has_method(method_name), "No method found")
		assert(resource, "No resource defined")
		prints("Visualize", resource, "for", target)
		target.call(method_name, resource)

	await get_tree().create_timer(INTERVAL).timeout
	_visualize_seconds_left -= INTERVAL
	_update()

func _exit_tree() -> void:
	visualize = false
