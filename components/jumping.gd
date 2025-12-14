class_name Jumping extends Node

@export var body: CharacterBody2D
@export var jump_force := 250.0
@export var max_jumps := 1

var _is_jumping := false
var _remaining := 1

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")

func jump() -> void:
	if _remaining > 0:
		body.velocity.y = -jump_force
		_remaining -= 1
		_is_jumping = true

func stop() -> void:
	if _is_jumping and body.velocity.y < 0:
		body.velocity.y /= 2
		_is_jumping = false

func _physics_process(_delta: float) -> void:
	if body.is_on_floor():
		_remaining = max_jumps
		_is_jumping = false
	elif not _is_jumping and _remaining == max_jumps:
		_remaining -= 1
