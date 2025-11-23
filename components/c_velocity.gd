class_name CVelocity extends Node

@export var body: CharacterBody2D
@export var acceleration := 10.0
@export var target_speed := 50.0

var _target_velocity := 0.0
var _is_running := false


func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")


func move(direction: float) -> void:
	_target_velocity = direction * target_speed
	if !_is_running: _update_velocity()


func stop() -> void:
	move(0.0)


func _update_velocity() -> void:
	_is_running = true
	while abs(body.velocity.x - _target_velocity) > 0.1:
		var lerp_weight := 1.0 - exp(-acceleration * get_physics_process_delta_time())
		body.velocity.x = lerp(body.velocity.x, _target_velocity, lerp_weight)
		await get_tree().physics_frame

	body.velocity.x = _target_velocity

	_is_running = false
