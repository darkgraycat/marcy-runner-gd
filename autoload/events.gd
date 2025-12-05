@tool
extends Node

# System events
signal global_event(message: String, tag: String)
func emit(message: String, tag: String = "default") -> void: global_event.emit(message, tag)

# Player events
signal player_attr_updated(key: String, value: float)
func emit_player_attr_updated(key: String, value: float) -> void: player_attr_updated.emit(key, value)

signal player_spawned(position: Vector2)
func emit_player_spawned(position: Vector2) -> void: player_spawned.emit(position)

signal player_died()
func emit_player_died() -> void: player_died.emit()

# UI events
signal update_ui()
func emit_update_ui() -> void: update_ui.emit()


# TODO: deprecate
signal effects_updated(status_effect_component: StatusEffectComponent)
# TODO: deprecate

func emit_effects_updated(status_effect_component: StatusEffectComponent) -> void:
	effects_updated.emit(status_effect_component)
