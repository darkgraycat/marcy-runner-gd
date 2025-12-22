class_name Gravity extends Node

signal landed()

@export var body: CharacterBody2D
@export var weight := 1.0:
	set(v): weight = v; _gravity_force = v * Globals.GRAVITY

var _gravity_force := 0.0
var _is_on_ground := false

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
	_gravity_force = weight * Globals.GRAVITY

func _physics_process(delta: float) -> void:
	if body.is_on_floor():
		if not _is_on_ground: landed.emit()
		_is_on_ground = true
	else:
		body.velocity.y += _gravity_force * delta
		_is_on_ground = false
