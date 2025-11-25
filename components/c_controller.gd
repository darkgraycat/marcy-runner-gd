class_name CController extends Control

signal move_pressed(axis: float)
signal move_released()
signal jump_pressed()
signal jump_released()

enum Key { Left, Right, Jump }

@export var scheme: Dictionary[CController.Key, StringName] = {
	Key.Left: &"ui_left",
	Key.Right: &"ui_right",
	Key.Jump: &"ui_select",
}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(scheme[Key.Left]) \
	or event.is_action_released(scheme[Key.Left]) \
	or event.is_action_pressed(scheme[Key.Right]) \
	or event.is_action_released(scheme[Key.Right]):
		var axis := Input.get_axis(scheme[Key.Left], scheme[Key.Right])
		if axis: move_pressed.emit(axis)
		else: move_released.emit()

	if event.is_action_pressed(scheme[Key.Jump]):
		jump_pressed.emit()
	if event.is_action_released(scheme[Key.Jump]):
		jump_released.emit()
