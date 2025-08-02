class_name Movement extends Node

@export var direction: Vector2 = Vector2.ZERO
@export var target_speed: float = 50
@export var acceleration: float = 0.5
@export var apply_gravity: bool = false

@onready var parent: CharacterBody2D = get_parent()

func _physics_process(delta: float) -> void:
	parent.velocity.x = lerp(
		parent.velocity.x,
		direction.x * target_speed,
		acceleration * delta
	)

	if !apply_gravity:
		parent.velocity.y = lerp(
			parent.velocity.y,
			direction.y * target_speed,
			acceleration * delta
		)
	elif !parent.is_on_floor():
		parent.velocity.y += Global.GRAVITY * delta

	parent.move_and_slide()
