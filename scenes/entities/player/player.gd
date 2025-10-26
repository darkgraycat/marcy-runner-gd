class_name Player extends CharacterBody2D

# variables #-------------------------------------------------------------------
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var jumping_component: JumpingComponent = $JumpingComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var status_effect_component: StatusEffectComponent = $StatusEffectComponent

enum State {Idle, Move, Jump, Die, Oiia}
const RAINBOW_MATERIAL = preload("res://scenes/entities/player/rainbow_material.tres")

var input_move: float = 0.0
var input_jump: bool = false
var jump_in_progress: bool = false
var current_state: String = "idle"
var state: State = State.Idle: set = set_state

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	movement_component.target_speed = Globals.MOVE_VELOCITY
	movement_component.acceleration = Globals.ACCELERATION
	jumping_component.target_force = Globals.JUMP_VELOCITY
	health_component.health = Variables.get_state(Variables.VarName.Lifes)
	health_component.health_changed.connect(_on_health_component_health_changed)
	health_component.died.connect(_on_health_component_died)
	status_effect_component.status_effect_applied.connect(_on_status_effect_component_status_effect_changed.bind(true))
	status_effect_component.status_effect_destroyed.connect(_on_status_effect_component_status_effect_changed.bind(false))

# builtin #---------------------------------------------------------------------
func _physics_process(_delta: float) -> void:
	input_move = 1 # NOTE: make player always run
	movement_component.direction = input_move
	jumping_component.jumping = input_jump

	if input_move:
		sprite_2d.flip_h = input_move < 0

	state = next_state()
	Events.emit_debug_message("Xvel %.1f" % velocity.x)

# method #----------------------------------------------------------------------
func set_state(new_state: State) -> void:
	if state == new_state: return
	state = new_state
	sprite_2d.modulate = Color.WHITE
	match state:
		State.Idle: animation_player.play(&"idle")
		State.Move: animation_player.play(&"walk")
		State.Jump: animation_player.play(&"jump")
		State.Oiia: animation_player.play(&"oiia")

# method #----------------------------------------------------------------------
func next_state() -> State:
	if state == State.Oiia:
		return State.Oiia
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
		"walk" if abs(velocity.x) > Globals.ACCELERATION else "idle"
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
	state = State.Idle
	status_effect_component.destroy_all_status_effects()
	animation_player.play("RESET")
	Events.emit_player_spawned(spawn_point)

# callback #--------------------------------------------------------------------
func _on_state_machine_enter_state(_idx: int, state_name: StringName) -> void:
	match state_name:
		"idle": prints("In idle state")
		"walk": prints("In walk state")
		"jump": prints("In jump state")
	pass # Replace with function body.

# callback #--------------------------------------------------------------------
func _on_health_component_health_changed(health: float) -> void:
	# TODO: add visuals thats depends on + or - amount
	Variables.set_state(Variables.VarName.Lifes, health)

# callback #--------------------------------------------------------------------
func _on_health_component_died() -> void:
	die.call_deferred()

# callback #--------------------------------------------------------------------
func _on_status_effect_component_status_effect_changed(status_effect: StatusEffectResource, is_applied: bool) -> void:
	match status_effect.name:
		"Oiia": state = State.Oiia if is_applied else State.Idle
	Events.emit_effects_updated(status_effect_component)
