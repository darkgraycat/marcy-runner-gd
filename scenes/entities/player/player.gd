class_name Player extends CharacterBody2D

# variables #-------------------------------------------------------------------
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var movement_component: MovementComponent = $MovementComponent
@onready var status_effect_component: StatusEffectComponent = $StatusEffectComponent
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

enum State {Idle, Move, Jump, Die, Oiia}
const RAINBOW_MATERIAL = preload("res://scenes/entities/player/rainbow_material.tres")

var input_move: float = 0.0
var input_jump: bool = false
var jump_in_progress: bool = false
var current_state: String = "idle"
var state: State = State.Idle: set = set_state

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	movement_component.max_velocity = Vector2(Global.MOVE_VELOCITY, Global.JUMP_VELOCITY)
	movement_component.acceleration = Vector2(Global.ACCELERATION, 0)
	movement_component.gravity = Vector2(0, Global.GRAVITY)
	# effect_reciever.effect_applied.connect(_on_effects_updated.bind(true))
	# effect_reciever.effect_destroyed.connect(_on_effects_updated.bind(false))

# builtin #---------------------------------------------------------------------
func _physics_process(_delta: float) -> void:
	movement_component.direction.x = input_move

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

	state = next_state()

	# var next_state := get_current_state()
	# if current_state != next_state:
	# 	current_state = next_state
	# 	animation_player.play(next_state)

	Events.emit_debug_message("PVel: %s - %s" % [int(velocity.x), int(movement_component.max_velocity.x)], 1)

# method #----------------------------------------------------------------------
func set_state(new_state: State) -> void:
	if state == new_state: return
	state = new_state
	match state:
		State.Idle: animation_player.play(&"idle")
		State.Move: animation_player.play(&"walk")
		State.Jump: animation_player.play(&"jump")

# method #----------------------------------------------------------------------
func next_state() -> State:
	if !is_on_floor():
		return State.Jump
	elif abs(input_move) > 0.01:
		return State.Move
	else:
		return State.Idle

# method #----------------------------------------------------------------------
func get_current_state() -> String:
	return (
		"jump" if not is_on_floor() else
		"walk" if abs(velocity.x) > Global.ACCELERATION else "idle"
	)

# method #----------------------------------------------------------------------
func die() -> void:
	set_physics_process(false)
	movement_component.set_physics_process(false)
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	Events.emit_player_died()

# method #----------------------------------------------------------------------
func respawn(spawn_point: Vector2) -> void:
	global_position = spawn_point
	set_physics_process(true)
	movement_component.set_physics_process(true)
	collision_shape_2d.disabled = false
	velocity = Vector2.ZERO
	animation_player.play("RESET")
	Events.emit_player_spawned(spawn_point)

# callback #--------------------------------------------------------------------
func _on_effects_updated(effect: EffectResource, is_applied: bool) -> void:
	print("_on_effects_updated called")
	var speed_bonus := 0.0

	match [effect.type, is_applied]:
		[EffectResource.EffectType.Speed, _]:
			prints("Speed bonus before", speed_bonus)
			#speed_bonus = effect_reciever.sum_effects(EffectResource.EffectType.Speed)
			prints("Speed bonus after", speed_bonus)
		[EffectResource.EffectType.Lifes, true]:
			if effect.value < 0:
				die.call_deferred()
		_: pass

	movement_component.max_velocity.x = Global.MOVE_VELOCITY + speed_bonus

	#Events.emit_effects_updated(effect_reciever)

# callback #--------------------------------------------------------------------
func _on_state_machine_enter_state(_idx: int, state_name: StringName) -> void:
	match state_name:
		"idle": prints("In idle state")
		"walk": prints("In walk state")
		"jump": prints("In jump state")
	pass # Replace with function body.
