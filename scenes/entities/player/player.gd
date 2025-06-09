class_name Player extends CharacterBody2D

@export var move_velocity: float = Global.MOVE_VELOCITY
@export var jump_velocity: float = Global.JUMP_VELOCITY

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

var input_move: float = 0.0
var input_jump: bool = false

func _physics_process(delta: float) -> void:
	velocity.x = move_velocity * input_move

	if input_move:
		animated_sprite_2d.flip_h = input_move < 0

	if input_jump:
		if is_on_floor():
			velocity.y = -jump_velocity
	elif velocity.y < 0:
		velocity.y /= 2

	if !is_on_floor():
		velocity.y += Global.GRAVITY * delta
		rotation = 0
	else:
		rotation = get_floor_normal().angle() + (PI / 2)

	animated_sprite_2d.play(get_current_state())
	move_and_slide()

func get_current_state() -> StringName:
	return (
		"jump" if not is_on_floor() else
		"walk" if input_move else "idle"
	)
