class_name Movement extends Node

@export var target_speed: float = 50.0
@export var acceleration: float = 10.0
@export var direction: float = 0.0

var body: CharacterBody2D
var velocity: float

func _ready() -> void:
	body = get_parent() as CharacterBody2D
	assert(body, "CharacterBody2D is not defined")

func accelerate(direction: float, delta: float) -> Movement:
	velocity = lerp(
		velocity,
		target_speed * direction,
		1 - exp(-acceleration * delta)
	)
	return self

func decelerate(delta: float) -> Movement:
	return accelerate(0, delta)

func move() -> void:
	body.velocity.x = velocity
	body.move_and_slide()
	velocity = body.velocity.x
