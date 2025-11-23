@abstract
class_name Component extends Node


@export var parent: Node = get_parent()
@export var processing: bool = true: set = set_processing


func _ready() -> void:
	if !parent: parent = get_parent()
	set_processing(processing)


static func find_component(node: Node, type: Variant) -> Component:
	return Utils.find_nodes_of_type(node, type)[0]


func set_processing(value: bool) -> void:
	processing = value
	set_physics_process(value)
	set_process(value)
