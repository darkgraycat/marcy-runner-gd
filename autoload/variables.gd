@tool
extends Node
signal updated()


var _state: Dictionary = {}

enum VarName {
	Score,
	Lifes,
}


func _init() -> void:
	for vname: float in VarName.values():
		_state[vname] = 0.0


func set_state(vname: VarName, value: float) -> void:
	_state[vname] = value
	updated.emit()


func get_state(vname: VarName) -> float:
	return _state.get(vname, 0.0)


func mod_state(vname: VarName, amount: float) -> void:
	set_state(vname, get_state(vname) + amount)
