class_name Player extends CharacterBody2D

@export var move_velocity: float = Global.MOVE_VELOCITY
@export var jump_velocity: float = Global.JUMP_VELOCITY

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

var input_move: float = 0.0
var input_jump: bool = false

var jump_in_progress: bool = false
var current_state: String = "idle"

func _physics_process(delta: float) -> void:
	_handle_moving()
	_handle_jumping()
	_handle_animation()
	move_and_slide()
	if !is_on_floor():
		velocity.y += Global.GRAVITY * delta


func get_current_state() -> StringName:
	return (
		"jump" if not is_on_floor() else
		"walk" if velocity.x else "idle"
	)


func _handle_moving() -> void:
	velocity.x = move_velocity * input_move


func _handle_jumping() -> void:
	if input_jump and !jump_in_progress:
		jump_in_progress = true
		if is_on_floor():
			velocity.y = -jump_velocity

	if !input_jump:
		jump_in_progress = false
		if velocity.y < 0:
			velocity.y /= 2


func _handle_animation() -> void:
	if input_move:
		animated_sprite_2d.flip_h = input_move < 0

	var next_state := get_current_state()
	if current_state != next_state:
		current_state = next_state
		animated_sprite_2d.play(next_state)
