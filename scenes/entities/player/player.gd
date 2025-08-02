class_name Player extends CharacterBody2D

## TODO: maybe we could use jumping component
@export var jump_velocity: float = Global.JUMP_VELOCITY

@onready var effect_reciever: EffectReciever = %EffectReciever
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var movement: Movement = %Movement

var input_move: float = 0.0
var input_jump: bool = false
var jump_in_progress: bool = false
var current_state: String = "idle"

func _ready() -> void:
	movement.target_speed = Global.MOVE_VELOCITY
	movement.acceleration = Global.ACCELERATION
	effect_reciever.effect_applied.connect(apply_effects)
	effect_reciever.effect_destroyed.connect(apply_effects)


func _physics_process(_delta: float) -> void:
	movement.direction.x = input_move

	if input_jump and !jump_in_progress:
		jump_in_progress = true
		if is_on_floor():
			velocity.y = -jump_velocity

	if !input_jump:
		jump_in_progress = false
		if velocity.y < 0:
			velocity.y /= 2

	if input_move:
		animated_sprite_2d.flip_h = input_move < 0

	var next_state := get_current_state()
	if current_state != next_state:
		current_state = next_state
		animated_sprite_2d.play(next_state)


func get_current_state() -> String:
	return (
		"jump" if not is_on_floor() else
		"walk" if abs(velocity.x) > Global.ACCELERATION else "idle"
	)


func die() -> void:
	prints("DIE")


func apply_effects(effect: EffectResource) -> void:
	match effect.type:
		EffectResource.EffectType.Speed:
			movement.target_speed = Global.MOVE_VELOCITY + \
			effect_reciever.get_effects_sum(EffectResource.EffectType.Speed)
		EffectResource.EffectType.Lifes:
			if effect.value < 0:
				die()
		_: pass

	Events.emit_effects_updated(effect_reciever)
