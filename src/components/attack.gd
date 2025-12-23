class_name Attack extends Area2D

@export var body: CharacterBody2D
@export var knockback_force := 50.0

func _ready() -> void:
	assert(body, "body is not defined")
