@tool
extends Node

signal updated()

var _state: Dictionary = {}

enum StateKey {
	Score,
	Lifes,
}

func _ready() -> void:
	for key: int in StateKey.values():
		_state[key] = null


func set_state(key: StateKey, value: Variant) -> void:
	_state[key] = value
	updated.emit()


func get_state(key: StateKey) -> Variant:
	return _state.get(key, null)


func incr_state(key: StateKey, amount: float) -> void:
	set_state(key, float(get_state(key)) + amount)


func decr_state(key: StateKey, amount: float) -> void:
	set_state(key, float(get_state(key)) + amount)
