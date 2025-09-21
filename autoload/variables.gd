@tool
extends Node
signal updated()

# variables #-------------------------------------------------------------------
var _state: Dictionary = {}

enum VariableKey {
	Score,
	Lifes,
}

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	for key: float in VariableKey.values():
		_state[key] = 0.0

# method #----------------------------------------------------------------------
func set_state(key: VariableKey, value: Variant) -> void:
	_state[key] = value
	updated.emit()

# method #----------------------------------------------------------------------
func get_state(key: VariableKey) -> float:
	return _state.get(key, 0.0)

# method #----------------------------------------------------------------------
func mod_state(key: VariableKey, amount: float) -> void:
	set_state(key, get_state(key) + amount)
