class_name Player extends CharacterBody2D

@export var controller: Controller

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var movement: Movement = $Components/Movement
@onready var jumping: Jumping = $Components/Jumping
@onready var gravity: Gravity = $Components/Gravity
@onready var health: Health = $Components/Health

const RAINBOW_MATERIAL = preload("res://src/entities/player/rainbow_material.tres")

func _ready() -> void:
	gravity.landed.connect(update_animation)

	health.died.connect(func() -> void:
		die.call_deferred())

	controller.jump_started.connect(func() -> void:
		jumping.jump()
		animation_player.play(&"jump"))

	controller.jump_stopped.connect(func() -> void:
		jumping.stop()
		update_animation())

	controller.move_started.connect(func(direction: float) -> void:
		movement.move(direction)
		sprite_2d.flip_h=direction < 0
		update_animation())

	controller.move_stopped.connect(func() -> void:
		movement.stop()
		update_animation())

func _physics_process(_delta: float) -> void:
	move_and_slide()
	Events.emit("%s" % jumping._remaining, "debug_player")

func update_animation() -> void:
	animation_player.play(
		&"jump" if not is_on_floor() else
		&"walk" if abs(movement._target_velocity) > 0.5 else
		&"idle"
	)

func die() -> void:
	set_physics_process(false)
	animation_player.play("die")
	await animation_player.animation_finished

func respawn(spawn_point: Vector2) -> void:
	print("respawn player")
	set_physics_process(true)
	velocity = Vector2.ZERO
	global_position = spawn_point
	animation_player.play(&"RESET")
	await animation_player.animation_finished
	update_animation()
