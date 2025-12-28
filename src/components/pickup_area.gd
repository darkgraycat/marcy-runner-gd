class_name PickupArea extends Area2D

signal picked(node: Node2D)

@export var filter_group: StringName

var _collision_shape: CollisionShape2D

func _ready() -> void:
	_collision_shape = find_children("", "CollisionShape2D").get(0)
	assert(_collision_shape, "_collision_shape is not found")
	body_entered.connect(func(node: Node2D) -> void:
		if filter_group and not node.is_in_group(filter_group):
			return
		picked.emit(node)
	)

func disable() -> void:
	_collision_shape.disabled = true

func enable() -> void:
	_collision_shape.disabled = false
