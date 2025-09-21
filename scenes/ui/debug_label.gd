class_name DebugLabel extends Label

@export var channel: int = 0

func _ready() -> void:
	if !G.DEBUG: hide()
	E.debug_message.connect(_on_debug_message)

func _on_debug_message(message: String, ch: int) -> void:
	if ch != 0 and ch != channel: return
	text = message
