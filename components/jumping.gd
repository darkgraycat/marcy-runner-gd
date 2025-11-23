class_name Jumping extends Node

@export var body: CharacterBody2D
@export var jumps_max: int = 1
@export var jump_force: float = 250.0

var is_jumping: bool = false
var jumps_left: int

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
	jumps_left = jumps_max

# func jump_start(delta: float) -> void:
# 	pass

func jump_start() -> bool:
	if is_jumping || jumps_left <= 0: return false
	body.velocity.y = -jump_force
	jumps_left -= 1
	is_jumping = true
	return is_jumping

func jump_release() -> void:
	pass

