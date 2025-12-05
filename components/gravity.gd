class_name Gravity extends Node

signal landed()

@export var body: CharacterBody2D
@export var weight := 1.0:
	set(v): weight = v; gravity_force = v * Globals.GRAVITY

var gravity_force := 0.0
var is_on_ground := false

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
	gravity_force = weight * Globals.GRAVITY

func _physics_process(delta: float) -> void:
	if body.is_on_floor():
		if !is_on_ground: landed.emit()
		is_on_ground = true
	else:
		body.velocity.y += gravity_force * delta
		is_on_ground = false

