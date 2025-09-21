class_name Component extends Node

# variables #-------------------------------------------------------------------
@export var parent: CharacterBody2D = get_parent()
@export var enable_processing: bool = true: set = set_enable_processing

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	if !parent: parent = get_parent()
	if !Util.validate(self)\
		.check(!parent, "Parent is not defined")\
		.check(2 + 2 == 4, "Omg, 2 + 2 equals 4")\
		.is_valid: return

# method #----------------------------------------------------------------------
static func get_component(from: Node, property: String, type_class: Variant) -> Component:
	var component: Component = from.get(property)
	if component && is_instance_of(component, type_class):
		return component
	return null

# method #----------------------------------------------------------------------
func set_enable_processing(value: bool) -> void:
	enable_processing = value
	set_physics_process(value)

# callback #--------------------------------------------------------------------
