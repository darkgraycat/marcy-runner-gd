class_name Jumping extends Node

@export var body: CharacterBody2D
@export var maximum_jumps := 1
@export var target_force := 250.0

var jump_in_progress := false
var jumps_remaining := 1

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")

func jump() -> void:
	if jumps_remaining > 0:
		body.velocity.y = -target_force
		jumps_remaining -= 1
		jump_in_progress = true

func stop() -> void:
	if jump_in_progress && body.velocity.y < 0:
		body.velocity.y /= 2
		jump_in_progress = false

func _physics_process(_delta: float) -> void:
	if body.is_on_floor():
		jumps_remaining = maximum_jumps
		jump_in_progress = false
