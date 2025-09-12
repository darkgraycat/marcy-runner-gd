class_name Player extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var movement: Movement = $Movement
@onready var effect_reciever: EffectReciever = $EffectReciever
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var input_move: float = 0.0
var input_jump: bool = false
var jump_in_progress: bool = false
var current_state: String = "idle"

func _ready() -> void:
	movement.target_speed = Vector2(Global.MOVE_VELOCITY, Global.JUMP_VELOCITY)
	movement.acceleration = Vector2(Global.ACCELERATION, 0)
	movement.gravity = Vector2(0, Global.GRAVITY)

	effect_reciever.effect_applied.connect(_on_effects_updated)
	effect_reciever.effect_destroyed.connect(_on_effects_updated)


func _physics_process(_delta: float) -> void:
	movement.direction.x = input_move

	if input_jump and !jump_in_progress:
		jump_in_progress = true
		if is_on_floor():
			velocity.y = -Global.JUMP_VELOCITY

	if !input_jump:
		jump_in_progress = false
		if velocity.y < 0:
			velocity.y /= 2

	if input_move:
		sprite_2d.flip_h = input_move < 0

	var next_state := get_current_state()
	if current_state != next_state:
		current_state = next_state
		animation_player.play(next_state)

	Events.emit_debug_message("%v" % velocity, 1)


func get_current_state() -> String:
	return (
		"jump" if not is_on_floor() else
		"walk" if abs(velocity.x) > Global.ACCELERATION else "idle"
	)


func die() -> void:
	print("PLAYER DIE")
	movement.set_physics_process(false)
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()


func _on_effects_updated(effect: EffectResource) -> void:
	match effect.type:
		EffectResource.EffectType.Speed:
			movement.target_speed.x = Global.MOVE_VELOCITY + \
			effect_reciever.get_effects_sum(EffectResource.EffectType.Speed)
		EffectResource.EffectType.Lifes:
			if effect.value < 0:
				die.call_deferred()
		_: pass

	Events.emit_effects_updated(effect_reciever)
