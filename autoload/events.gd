@tool
extends Node

signal update_ui()
func emit_update_ui() -> void: update_ui.emit()

signal effects_updated(effect_reciever: EffectReciever)
func emit_effects_updated(effect_reciever: EffectReciever) -> void: effects_updated.emit(effect_reciever)

signal debug_message(message: String, channel: int)
func emit_debug_message(message: String, channel: int = 0) -> void: debug_message.emit(message, channel)

signal player_spawned(point: Vector2)
func emit_player_spawned(point: Vector2) -> void: player_spawned.emit(point)

signal player_died()
func emit_player_died() -> void: player_died.emit()
