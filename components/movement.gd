class_name Movement extends Node

@export var body: CharacterBody2D
@export var acceleration := 5.0
@export var target_speed := 100.0

var target_velocity := 0.0

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")

func move(direction: float) -> void:
	target_velocity = direction * target_speed

func stop() -> void:
	move(0.0)

func _physics_process(delta: float) -> void:
	body.velocity.x = lerp(
		body.velocity.x,
		target_velocity,
		1.0 - exp(-acceleration * delta)
	)
