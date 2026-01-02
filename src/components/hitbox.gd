class_name Hitbox extends Area2D

@export var body: CharacterBody2D
@export var damage := 0
@export var knockback := Vector2.ZERO

func _ready() -> void:
	assert(body, "body is not defined")
