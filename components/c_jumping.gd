class_name CJumping extends Node

@export var body: CharacterBody2D
@export var jumps_max: int = 10
@export var jump_force: float = 250.0

var is_jumping: bool = false
var jumps_left: int

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
	jumps_left = jumps_max

func jump() -> bool:
	if is_jumping || jumps_left <= 0: return false
	body.velocity.y = -jump_force * 5
	jumps_left -= 1
	is_jumping = true
	return is_jumping

func stop() -> void:
	is_jumping = false

	if body.velocity.y < 0:
		body.velocity.y /= 2

	pass
