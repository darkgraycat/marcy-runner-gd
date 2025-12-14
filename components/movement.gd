class_name Movement extends Node

@export var body: CharacterBody2D
@export var acceleration := 5.0
@export var max_speed := 100.0:
	set(v): max_speed = v; _target_velocity = v * _direction

var _target_velocity := 0.0
var _direction := 0.0

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")

func move(new_direction: float) -> void:
	_direction = new_direction
	_target_velocity = new_direction * max_speed

func stop() -> void:
	move(0.0)

func _physics_process(delta: float) -> void:
	body.velocity.x = lerp(
		body.velocity.x,
		_target_velocity,
		1.0 - exp(-acceleration * delta)
	)
