class_name Component extends Node

# variables #-------------------------------------------------------------------
@export var parent: CharacterBody2D = get_parent()
@export var processing: bool = true: set = set_processing

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	if !parent: parent = get_parent()

# method #----------------------------------------------------------------------
static func find_component(node: Node, type: Variant) -> Component:
	return U.find_of_type(node, type)[0]

# method #----------------------------------------------------------------------
func set_processing(value: bool) -> void:
	processing = value
	await ready
	set_physics_process(value)
	set_process(value)

# callback #--------------------------------------------------------------------
