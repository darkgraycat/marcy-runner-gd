@tool
extends Node

signal update_ui()
func emit_update_ui() -> void: update_ui.emit()

signal effects_updated(effect_reciever: EffectReciever)
func emit_effects_updated(effect_reciever: EffectReciever) -> void: effects_updated.emit(effect_reciever)
