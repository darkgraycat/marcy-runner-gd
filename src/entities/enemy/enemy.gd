class_name Enemy extends CharacterBody2D

@export var movement_direction := 0.0

@export var collision_shape_2d: CollisionShape2D
@export var sprite_2d: Sprite2D
@export var animation_player: AnimationPlayer
@export var hurbox_area_2d: Area2D

@onready var movement: Movement = $Components/Movement
@onready var gravity: Gravity = $Components/Gravity

var is_dying: bool = false

func _ready() -> void:
	assert(sprite_2d, "sprite_2d is not defined")
	assert(animation_player, "animation_player is not defined")
	assert(hurbox_area_2d, "hurbox_area_2d is not defined")
	hurbox_area_2d.body_entered.connect(_on_hurbox_area_2d_body_entered)
	animation_player.play("idle")

	if movement: movement.move(movement_direction)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func die() -> void:
	set_physics_process(false)
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()

func damage(body: CharacterBody2D) -> void:
	if is_dying: return
	is_dying = true
	if !body.is_in_group(Global.GROUP_NAME_PLAYER): return

	# TODO: redo damage logic
	die.call_deferred()

func _on_hurbox_area_2d_body_entered(body: Node2D) -> void:
	damage(body)
