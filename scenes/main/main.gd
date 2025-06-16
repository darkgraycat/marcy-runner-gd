extends Node2D

@onready var level: Level = %Level
@onready var debug_label: Label = %DebugLabel

@onready var label: Label = $UiCanvasLayer/PanelContainer/HBoxContainer/Label

func _ready() -> void:
	Util.notification.connect(_on_notification)

func _on_notification(message: String, ch: int) -> void:
	if ch != 1: return
	debug_label.text = message

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()


func _on_state_manager_state_updated(state: Dictionary) -> void:
	label.text = "Score %s\nSpeed %s" % [state.score, state.bonus_speed]
