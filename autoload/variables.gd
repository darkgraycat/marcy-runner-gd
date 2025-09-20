@tool
extends Node

signal updated()

var _state: Dictionary = {}

enum VariableKey {
	Score,
	Lifes,
}

func _ready() -> void:
	for key: float in VariableKey.values():
		_state[key] = 0.0


func set_state(key: VariableKey, value: Variant) -> void:
	_state[key] = value
	updated.emit()


func get_state(key: VariableKey) -> float:
	return _state.get(key, 0.0)


func mod_state(key: VariableKey, amount: float) -> void:
	set_state(key, get_state(key) + amount)
