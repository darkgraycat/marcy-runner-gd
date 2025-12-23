class_name Item extends Area2D

@export var attributes_effects: Array[AttributesEffect] = []

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	assert(animated_sprite_2d, "animated_sprite_2d is not defined")
	assert(collision_shape_2d, "collision_shape_2d is not defined")
	body_entered.connect(_on_body_entered)
	animated_sprite_2d.play("idle")

func die() -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()

func collect(target: Node2D) -> void:
	if !target.is_in_group(Global.GROUP_NAME_PLAYER): return
	if !target.is_in_group(Attributes.GROUP_NAME): return

	var attributes := Attributes.get_attributes(target)
	if !attributes: return

	for e in attributes_effects:
		e.apply(attributes)

	die.call_deferred()

func _on_body_entered(body: Node2D) -> void:
	collect(body)
