class_name Health extends Node

signal died()
signal changed(health: float)

@export var maximum := 10.0

var current := 3.0: set = set_current

func _ready() -> void:
	current = maximum

func damage(amount: float) -> void:
	current = max(current - amount, 0)

func heal(amount: float) -> void:
	current = min(current + amount, maximum)

func set_current(value: float) -> void:
	if value > maximum: return
	if current == value: return
	current = value
	changed.emit(current)
	if current <= 0:
		died.emit()
