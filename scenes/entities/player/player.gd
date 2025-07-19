class_name Player extends CharacterBody2D

@export var move_velocity: float = Global.MOVE_VELOCITY
@export var jump_velocity: float = Global.JUMP_VELOCITY

@onready var effect_reciever: EffectReciever = %EffectReciever
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

var input_move: float = 0.0
var input_jump: bool = false
var jump_in_progress: bool = false
var current_state: String = "idle"

func _ready() -> void:
	effect_reciever.effect_applied.connect(apply_effects)
	effect_reciever.effect_destroyed.connect(apply_effects)


func _physics_process(delta: float) -> void:
	velocity.x = move_velocity * input_move

	if input_jump and !jump_in_progress:
		jump_in_progress = true
		if is_on_floor():
			velocity.y = -jump_velocity

	if !input_jump:
		jump_in_progress = false
		if velocity.y < 0:
			velocity.y /= 2

	if !is_on_floor():
		velocity.y += Global.GRAVITY * delta

	if input_move:
		animated_sprite_2d.flip_h = input_move < 0

	var next_state := get_current_state()
	if current_state != next_state:
		current_state = next_state
		animated_sprite_2d.play(next_state)

	move_and_slide()


func get_current_state() -> String:
	return (
		"jump" if not is_on_floor() else
		"walk" if velocity.x else "idle"
	)


func apply_effects(effect: EffectResource) -> void:
	if effect.type == EffectResource.EffectType.Speed:
		move_velocity = Global.MOVE_VELOCITY + \
		effect_reciever.get_effects_sum(EffectResource.EffectType.Speed)

	Events.emit_effects_updated(effect_reciever)
