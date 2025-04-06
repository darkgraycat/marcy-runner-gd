class_name Player extends CharacterBody2D

@export var move_velocity: float = Global.DEFAULT_MOVE_VELOCITY
@export var jump_velocity: float = Global.DEFAULT_JUMP_VELOCITY

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var input_move: float = 0.0
var input_jump: bool = false

func _physics_process(delta: float) -> void:
	if input_move:
		animated_sprite_2d.scale.x = input_move
		velocity.x = input_move * move_velocity
	else:
		velocity.x = move_toward(velocity.x, 0, move_velocity)

	if input_jump:
		if is_on_floor():
			velocity.y = -jump_velocity
	elif velocity.y < 0:
		velocity.y /= 2

	if !is_on_floor():
		velocity.y += Global.GRAVITY * delta

	animated_sprite_2d.play(get_current_state())
	move_and_slide()

func get_current_state() -> StringName:
	return (
		"jump" if not is_on_floor() else
		"walk" if input_move else "idle"
	)
