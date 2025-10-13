@tool
extends Node
signal update_ui()
signal effects_updated(status_effect_component: StatusEffectComponent)
signal debug_message(message: String, channel: int)
signal player_spawned(point: Vector2)
signal player_died()

# method #----------------------------------------------------------------------
func emit_update_ui() -> void:
	update_ui.emit()

# method #----------------------------------------------------------------------
func emit_effects_updated(status_effect_component: StatusEffectComponent) -> void:
	effects_updated.emit(status_effect_component)

# method #----------------------------------------------------------------------
func emit_debug_message(message: String, channel: int = 0) -> void:
	debug_message.emit(message, channel)

# method #----------------------------------------------------------------------
func emit_player_spawned(point: Vector2) -> void:
	player_spawned.emit(point)

# method #----------------------------------------------------------------------
func emit_player_died() -> void:
	player_died.emit()
