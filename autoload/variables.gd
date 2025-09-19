@tool
extends Node

signal updated()

var _state: Dictionary = {}

enum VariableKey {
	Score,
	Lifes,
}

func _ready() -> void:
	for key: int in VariableKey.values():
		_state[key] = null


func set_state(key: VariableKey, value: Variant) -> void:
	_state[key] = value
	updated.emit()


func get_state(key: VariableKey) -> Variant:
	return _state.get(key, null)


func mod_state(key: VariableKey, amount: float) -> void:
	set_state(key, float(get_state(key)) + amount)
