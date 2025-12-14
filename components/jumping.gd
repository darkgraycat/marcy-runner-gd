class_name Jumping extends Node

@export var body: CharacterBody2D
@export var jump_velocity := 250.0
@export var maximum_jumps := 1

var jumping := false
var remaining := 1

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")

func jump() -> void:
	if remaining > 0:
		body.velocity.y = -jump_velocity
		remaining -= 1
		jumping = true

func stop() -> void:
	if jumping && body.velocity.y < 0:
		body.velocity.y /= 2
		jumping = false

func _physics_process(_delta: float) -> void:
	if body.is_on_floor():
		remaining = maximum_jumps
		jumping = false
	elif remaining == maximum_jumps && !jumping:
		remaining -= 1
