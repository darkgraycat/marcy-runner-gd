extends Node2D

@onready var level: Level = %Level
@onready var debug_label: Label = %DebugLabel

func _ready() -> void:
	Util.notification.connect(_on_notification)

func _on_notification(message: String, ch: int) -> void:
	if ch != 1: return
	debug_label.text = message
