class_name Component extends Node

# variables #-------------------------------------------------------------------
@export var parent: CharacterBody2D = get_parent()
@export var enable_processing: bool = true: set = set_enable_processing

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
func set_enable_processing(value: bool) -> void:
	enable_processing = value
	set_physics_process(value)

# callback #--------------------------------------------------------------------
