class_name DebugLabel extends Label

@export var tag_postfix: String

func _ready() -> void:
	if !Globals.DEBUG: hide()
	Events.global_event.connect(_on_global_event)

func _on_global_event(message: String, tag: String) -> void:
	if tag != "debug_" + tag_postfix: return
	text = message
