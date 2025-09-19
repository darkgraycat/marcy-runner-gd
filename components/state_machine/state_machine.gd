class_name StateMachine extends Node

signal enter_state(idx: int, name: StringName)
signal leave_state(idx: int, name: StringName)

@export var parent: Node = get_parent()
@export var states: Array[StringName] = ["initial"]

var state_idx: int = 0: set = set_state

func set_state(new_state_idx: int) -> int:
	leave_state.emit(state_idx, states[state_idx])
	state_idx = new_state_idx
	enter_state.emit(state_idx, states[state_idx])
	return state_idx
