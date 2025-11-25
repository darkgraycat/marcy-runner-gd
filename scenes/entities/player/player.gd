class_name Player extends CharacterBody2D

@export var c_controller: CController

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var jumping_component: JumpingComponent = $JumpingComponent
@onready var status_effect_component: StatusEffectComponent = $StatusEffectComponent

@onready var c_attributes: CAttributes = $Components/CAttributes
@onready var c_velocity: CVelocity = $Components/CVelocity
@onready var c_jumping: CJumping = $Components/CJumping
@onready var c_gravity: CGravity = $Components/CGravity

enum State {Idle, Move, Jump, Die, Oiia}
const RAINBOW_MATERIAL = preload("res://scenes/entities/player/rainbow_material.tres")

var input_move: float = 0.0
var input_jump: bool = false
var jump_in_progress: bool = false
var current_state: String = "idle"
var state: State = State.Idle: set = set_state


func _ready() -> void:
	c_velocity.target_speed = c_attributes.getv(AttrPlayer.Key.MoveVelocity)
	c_velocity.acceleration = c_attributes.getv(AttrPlayer.Key.Acceleration)
	c_jumping.jump_force = c_attributes.getv(AttrPlayer.Key.JumpVelocity)
	c_jumping.jumps_max = c_attributes.geti(AttrPlayer.Key.JumpsAmount)

	jumping_component.target_force = c_attributes.getv(AttrPlayer.Key.JumpVelocity)

	health_component.health = c_attributes.getv(AttrPlayer.Key.Health)

	health_component.died.connect(func() -> void:
		die.call_deferred())
	health_component.health_changed.connect(func(health: float) -> void:
		c_attributes.setv(AttrPlayer.Key.Health, health)
		Events.emit_player_attr_updated(AttrPlayer.Key.Health, health))

	c_attributes.changed.connect(Events.emit_player_attr_updated)

	c_controller.jump_started.connect(c_jumping.jump)
	c_controller.jump_stopped.connect(c_jumping.stop)
	c_controller.move_started.connect(c_velocity.move)
	c_controller.move_stopped.connect(c_velocity.stop)

	# to deprecate
	status_effect_component.status_effect_applied.connect(_on_status_effect_component_status_effect_changed.bind(true))
	status_effect_component.status_effect_destroyed.connect(_on_status_effect_component_status_effect_changed.bind(false))


func _physics_process(delta: float) -> void:
	# input_move = 1 # NOTE: make player always run
	# movement_component.direction = input_move
	# movement.direction = input_move
	# movement.accelerate(input_move, delta).move()
	c_gravity.apply_gravity(delta)

	jumping_component.jumping = input_jump

	move_and_slide()

	if input_move:
		sprite_2d.flip_h = input_move < 0

	state = next_state()
	Events.emit_debug_message("Xvel %.1f" % velocity.x)


func set_state(new_state: State) -> void:
	if state == new_state: return
	state = new_state
	sprite_2d.modulate = Color.WHITE
	match state:
		State.Idle: animation_player.play(&"idle")
		State.Move: animation_player.play(&"walk")
		State.Jump: animation_player.play(&"jump")
		State.Oiia: animation_player.play(&"oiia")


func next_state() -> State:
	if state == State.Oiia:
		return State.Oiia
	if !is_on_floor():
		return State.Jump
	elif abs(c_velocity._target_velocity) > 0.5:
		return State.Move
	else:
		return State.Idle


func get_current_state() -> String:
	return (
		"jump" if not is_on_floor() else
		"walk" if abs(velocity.x) > Globals.ACCELERATION else "idle"
	)


func die() -> void:
	set_physics_process(false)
	# movement_component.set_physics_process(false)
	c_velocity.set_physics_process(false)

	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	Events.emit_player_died()


func respawn(spawn_point: Vector2) -> void:
	global_position = spawn_point
	set_physics_process(true)
	# movement_component.set_physics_process(true)
	c_velocity.set_physics_process(true)
	collision_shape_2d.disabled = false
	velocity = Vector2.ZERO
	state = State.Idle
	status_effect_component.destroy_all_status_effects()
	animation_player.play("RESET")
	Events.emit_player_spawned(spawn_point)


func _on_state_machine_enter_state(_idx: int, state_name: StringName) -> void:
	match state_name:
		"idle": prints("In idle state")
		"walk": prints("In walk state")
		"jump": prints("In jump state")
	pass # Replace with function body.


func _on_status_effect_component_status_effect_changed(status_effect: StatusEffectResource, is_applied: bool) -> void:
	match status_effect.name:
		"Oiia": state = State.Oiia if is_applied else State.Idle
	Events.emit_effects_updated(status_effect_component)
