class_name Gravity extends Node

@export var body: CharacterBody2D
@export var weight: float = 1.0:
	set(v): weight = v; gravity_force = v * Globals.GRAVITY

var gravity_force: float


func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
	gravity_force = weight * Globals.GRAVITY


func apply_gravity(delta: float) -> void:
	if !body.is_on_floor():
		body.velocity.y += gravity_force * delta


func is_falling() -> bool:
	return  !body.is_on_floor() && body.velocity.y > 0
