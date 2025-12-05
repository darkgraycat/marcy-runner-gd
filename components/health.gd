class_name Health extends Node

signal died()
signal changed(amount: float, health: float)

@export var maximum_health := 10.0

var current_health := 3.0

func _ready() -> void:
	current_health = maximum_health

func damage(amount: float) -> void:
	current_health = max(current_health - amount, 0)
	changed.emit(amount, current_health)
	if current_health <= 0:
		died.emit()

func heal(amount: float) -> void:
	current_health = min(current_health + amount, maximum_health)
	changed.emit(amount, current_health)
