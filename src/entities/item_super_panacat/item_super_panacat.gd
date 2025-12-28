class_name ItemSuperPanacat extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	body_entered.connect(collect)

func die() -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()

func collect(body: CharacterBody2D) -> void:
	if body.is_in_group(Global.GROUP_NAME_PLAYER):
		die.call_deferred()
