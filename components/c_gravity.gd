class_name CGravity extends Node

@export var body: CharacterBody2D
@export var weight := 1.0:
	set(v): weight = v; _gravity_force = v * Globals.GRAVITY

var _gravity_force := 0.0
var _is_running := false


func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
	_gravity_force = weight * Globals.GRAVITY



func apply_gravity(delta: float) -> void:
	if !body.is_on_floor():
		body.velocity.y += _gravity_force * delta


func is_falling() -> bool:
	return  !body.is_on_floor() && body.velocity.y > 0


func _update_velocity() -> void:
	_is_running = true
	while body.velocity.y > 0 && !body.is_on_floor():
		body.velocity.y += _gravity_force * get_physics_process_delta_time()
		await get_tree().physics_frame

	_is_running = false
