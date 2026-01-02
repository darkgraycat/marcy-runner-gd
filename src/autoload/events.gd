@tool
extends Node

# System events
signal global_event(message: String, tag: String)
func emit(message: String, tag: String = "default") -> void: global_event.emit(message, tag)

# Player events
signal player_item_collected(item: Node2D)
func emit_player_item_collected(item: Node2D) -> void: player_item_collected.emit(item)

signal player_spawned(position: Vector2)
func emit_player_spawned(position: Vector2) -> void: player_spawned.emit(position)

signal player_died()
func emit_player_died() -> void: player_died.emit()

signal player_hit()
func emit_player_hit() -> void: player_hit.emit()

# UI events
signal update_ui()
func emit_update_ui() -> void: update_ui.emit()
