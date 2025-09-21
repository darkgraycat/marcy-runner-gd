@tool
extends Node
signal updated()

# variables #-------------------------------------------------------------------
var _state: Dictionary = {}

enum VarName {
	Score,
	Lifes,
}

# builtin #---------------------------------------------------------------------
func _init() -> void:
	for vname: float in VarName.values():
		_state[vname] = 0.0

# method #----------------------------------------------------------------------
func set_state(vname: VarName, value: float) -> void:
	U.log("Set state ", get_state(vname), " -> ", value)
	_state[vname] = value
	updated.emit()

# method #----------------------------------------------------------------------
func get_state(vname: VarName) -> float:
	return _state.get(vname, 0.0)

# method #----------------------------------------------------------------------
func mod_state(vname: VarName, amount: float) -> void:
	set_state(vname, get_state(vname) + amount)
