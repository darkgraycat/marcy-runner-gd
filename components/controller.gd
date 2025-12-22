class_name Controller extends Control

signal move_started(axis: float)
signal move_stopped()
signal jump_started()
signal jump_stopped()

enum Key {Left, Right, Jump}

@export var scheme: Dictionary[Controller.Key, StringName] = {
	Key.Left: &"move_left",
	Key.Right: &"move_right",
	Key.Jump: &"jump",
}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(scheme[Key.Left]) \
	or event.is_action_released(scheme[Key.Left]) \
	or event.is_action_pressed(scheme[Key.Right]) \
	or event.is_action_released(scheme[Key.Right]):
		var axis := Input.get_axis(scheme[Key.Left], scheme[Key.Right])
		if axis: move_started.emit(axis)
		else: move_stopped.emit()

	if event.is_action_pressed(scheme[Key.Jump]):
		jump_started.emit()
	if event.is_action_released(scheme[Key.Jump]):
		jump_stopped.emit()
