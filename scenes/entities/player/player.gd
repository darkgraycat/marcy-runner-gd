class_name Player extends CharacterBody2D

# variables #-------------------------------------------------------------------
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var movement_component: MovementComponent = $MovementComponent
@onready var status_effect_component: StatusEffectComponent = $StatusEffectComponent
@onready var health_component: HealthComponent = $HealthComponent

enum State {Idle, Move, Jump, Die, Oiia}
const RAINBOW_MATERIAL = preload("res://scenes/entities/player/rainbow_material.tres")

var input_move: float = 0.0
var input_jump: bool = false
var jump_in_progress: bool = false
var current_state: String = "idle"
var state: State = State.Idle: set = set_state

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	movement_component.max_velocity = Vector2(G.MOVE_VELOCITY, G.JUMP_VELOCITY)
	movement_component.acceleration = Vector2(G.ACCELERATION, 0)
	movement_component.gravity = Vector2(0, G.GRAVITY)
	health_component.health = V.get_state(V.VarName.Lifes)
	health_component.health_changed.connect(_on_health_component_health_changed)
	health_component.died.connect(_on_health_component_died)

# builtin #---------------------------------------------------------------------
func _physics_process(_delta: float) -> void:
	movement_component.direction.x = input_move

	if input_jump and !jump_in_progress:
		jump_in_progress = true
		if is_on_floor():
			velocity.y = -G.JUMP_VELOCITY

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

	E.emit_debug_message("PVel: %s - %s" % [int(velocity.x), int(movement_component.max_velocity.x)], 1)

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
		"walk" if abs(velocity.x) > G.ACCELERATION else "idle"
	)

# method #----------------------------------------------------------------------
func die() -> void:
	set_physics_process(false)
	movement_component.set_physics_process(false)
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	E.emit_player_died()

# method #----------------------------------------------------------------------
func respawn(spawn_point: Vector2) -> void:
	global_position = spawn_point
	set_physics_process(true)
	movement_component.set_physics_process(true)
	collision_shape_2d.disabled = false
	velocity = Vector2.ZERO
	animation_player.play("RESET")
	E.emit_player_spawned(spawn_point)

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
	V.set_state(V.VarName.Lifes, health)

# callback #--------------------------------------------------------------------
func _on_health_component_died() -> void:
	die.call_deferred()
