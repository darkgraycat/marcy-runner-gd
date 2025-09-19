class_name StateResource extends Resource

signal enter(state: StateResource)
func emit_enter() -> void: enter.emit(self)

signal leave(state: StateResource)
func emit_leave() -> void: leave.emit(self)

@export var state_name: StringName

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
