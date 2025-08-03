class_name Movement extends Node

@export var direction: Vector2 = Vector2.ZERO
@export var target_speed: Vector2 = Vector2.ZERO
@export var acceleration: Vector2 = Vector2.ZERO
@export var gravity: Vector2 = Vector2.ZERO

@onready var parent: CharacterBody2D = get_parent()

func _physics_process(delta: float) -> void:
	parent.velocity.x = lerp(
		parent.velocity.x,
		direction.x * target_speed.x,
		acceleration.x * delta,
	) + gravity.x * delta

	parent.velocity.y = lerp(
		parent.velocity.y,
		direction.y * target_speed.y,
		acceleration.y * delta,
	) + gravity.y * delta

	parent.move_and_slide()
