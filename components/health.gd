class_name Health extends Node

signal died()
signal changed(amount: float, health: float)

@export var maximum := 10.0

var current := 3.0

func _ready() -> void:
	current = maximum

func damage(amount: float) -> void:
	current = max(current - amount, 0)
	changed.emit(amount, current)
	if current <= 0:
		died.emit()

func heal(amount: float) -> void:
	current = min(current + amount, maximum)
	changed.emit(amount, current)
