class_name Movement extends Node

@export var direction: Vector2 = Vector2.ZERO
@export var target_speed: float = 50
@export var acceleration: float = 0.5

@onready var actor: CharacterBody2D = get_parent()

func _physics_process(delta: float) -> void:
	actor.velocity = actor.velocity.lerp(
		direction * target_speed,
		acceleration * delta
	)
	actor.move_and_slide()

