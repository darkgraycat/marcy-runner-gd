class_name Controller extends Control

signal move_pressed(direction: float)
signal move_released()
signal jump_pressed()
signal jump_released()

@export var scheme: Dictionary[String, StringName] = {
	left = &"ui_left",
	right = &"ui_right",
	jump = &"ui_select",
}


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(scheme["left"])\
	or event.is_action_pressed(scheme["right"]):
		var direction := Input.get_axis(scheme["left"], scheme["right"])
		if direction != 0.0: move_pressed.emit(direction)

	if event.is_action_released(scheme["left"]) \
	or event.is_action_released(scheme["right"]):
		move_released.emit()

	if event.is_action_pressed(scheme["jump"]):
		jump_pressed.emit()
	if event.is_action_released(scheme["jump"]):
		jump_released.emit()
