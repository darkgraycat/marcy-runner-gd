@tool
extends Node


enum HealthModType {GENERIC}

var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity", 500)
var VIEWPORT_WIDTH: int = ProjectSettings.get_setting("display/window/size/viewport_width", 320)
var VIEWPORT_HEIGHT: int = ProjectSettings.get_setting("display/window/size/viewport_height", 180)

const TILE_SIZE: int = 16

const MOVE_VELOCITY: float = 100.0
const JUMP_VELOCITY: float = 250.0
const ACCELERATION: float = 5.0

const GROUP_NAME_PLAYER: StringName = "Player"
const GROUP_NAME_ITEMS: StringName = "Items"
const GROUP_NAME_ENEMIES: StringName = "Enemies"

var DEBUG: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if not Engine.is_editor_hint():
		if event.is_action_pressed("quit"):
			get_tree().quit()
