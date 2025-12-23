class_name Attack extends Area2D

@export var body: CharacterBody2D
@export var knockback_force := 50.0

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
