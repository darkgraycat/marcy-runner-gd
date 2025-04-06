extends Node2D

@onready var level: Level = $Level
@onready var debug_label: Label = $UiCanvasLayer/DebugLabel

func _ready() -> void:
	Util.notification.connect(_on_notification)
	load_level(0)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		self.get_tree().quit()

func _on_notification(message: String, ch: int) -> void:
	if ch != 1: return
	debug_label.text = message

func load_level(index: int) -> void:
	var path: String = "res://resources/levels/level_%d.tres" % index
	var level_params := Util.load_resource(path) as LevelParams
	level.set_params(level_params)
