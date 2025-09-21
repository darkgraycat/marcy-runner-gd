class_name Component extends Node

# variables #-------------------------------------------------------------------
@export var parent: CharacterBody2D = get_parent()
@export var auto_handle: bool = true: set = set_auto_handle

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	if !parent: parent = get_parent()

# method #----------------------------------------------------------------------
static func find_in_node(node: Node, property: String, type_class: Variant) -> Component:
	var component: Component = node.get(property)
	if component && is_instance_of(component, type_class):
		return component
	return null

# method #----------------------------------------------------------------------
func set_auto_handle(value: bool) -> void:
	auto_handle = value
	await ready
	set_physics_process(value)
	set_process(value)

# callback #--------------------------------------------------------------------
