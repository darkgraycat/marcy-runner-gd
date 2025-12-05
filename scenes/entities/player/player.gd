class_name Player extends CharacterBody2D

@export var c_controller: CController

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var movement: Movement = $Components/Movement
@onready var jumping: Jumping = $Components/Jumping
@onready var gravity: Gravity = $Components/Gravity
@onready var health: Health = $Components/Health
@onready var attributes: Attributes = $Components/Attributes

enum State {Idle, Move, Jump, Die, Oiia}
const RAINBOW_MATERIAL = preload("res://scenes/entities/player/rainbow_material.tres")

var input_move: float = 0.0
var input_jump: bool = false
var jump_in_progress: bool = false
var current_state: String = "idle"
var state: State = State.Idle: set = set_state


func _ready() -> void:
	movement.target_speed = attributes.getv(AttrPlayer.Key.MoveVelocity)
	movement.acceleration = attributes.getv(AttrPlayer.Key.Acceleration)
	gravity.weight = attributes.getv(AttrPlayer.Key.BodyWeight)
	health.maximum_health = attributes.getv(AttrPlayer.Key.Health)
	jumping.target_force = attributes.getv(AttrPlayer.Key.JumpVelocity)
	jumping.maximum_jumps = attributes.geti(AttrPlayer.Key.JumpsAmount)
	gravity.landed.connect(func() -> void:
		print("Landed")
		animation_player.play(&"idle")
	)

	health.died.connect(func() -> void:
		die.call_deferred())
	health.changed.connect(func(health: float) -> void:
		attributes.setv(AttrPlayer.Key.Health, health)
		Events.emit_player_attr_updated(AttrPlayer.Key.Health, health))

	attributes.changed.connect(Events.emit_player_attr_updated)

	c_controller.jump_started.connect(func() -> void:
		jumping.jump()
		if is_on_floor(): animation_player.play(&"jump"))

	c_controller.jump_stopped.connect(func() -> void:
		jumping.stop()
		if !is_on_floor():
			# TODO: add fall animation
			animation_player.play(&"jump"))

	c_controller.move_started.connect(func(direction: float) -> void:
		movement.move(direction)
		sprite_2d.flip_h = direction < 0
		if is_on_floor(): animation_player.play(&"walk"))

	c_controller.move_stopped.connect(func() -> void:
		movement.stop()
		if is_on_floor(): animation_player.play(&"idle"))
	

func _physics_process(_delta: float) -> void:
	move_and_slide()


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
	#elif abs(c_velocity._target_velocity) > 0.5:
	elif abs(movement.target_velocity) > 0.5:
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
	# c_velocity.set_physics_process(false)
	movement.set_physics_process(false)

	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	Events.emit_player_died()


func respawn(spawn_point: Vector2) -> void:
	global_position = spawn_point
	set_physics_process(true)
	# movement_component.set_physics_process(true)
	#c_velocity.set_physics_process(true)
	movement.set_physics_process(false)
	collision_shape_2d.disabled = false
	velocity = Vector2.ZERO
	state = State.Idle
	#status_effect_component.destroy_all_status_effects()
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
	#Events.emit_effects_updated(status_effect_component)
