class_name Movement extends Node

@export var body: CharacterBody2D
@export var acceleration := 5.0
@export var speed := 100.0:
	set(v): speed = v; target_velocity = v * direction

var target_velocity := 0.0
var direction := 0.0

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")

func move(new_direction: float) -> void:
	direction = new_direction
	target_velocity = new_direction * speed

func stop() -> void:
	move(0.0)

func _physics_process(delta: float) -> void:
	body.velocity.x = lerp(
		body.velocity.x,
		target_velocity,
		1.0 - exp(-acceleration * delta)
	)
