@tool
extends Node

var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity", 500)
var VIEWPORT_WIDTH: int = ProjectSettings.get_setting("display/window/size/viewport_width", 320)
var VIEWPORT_HEIGHT: int = ProjectSettings.get_setting("display/window/size/viewport_height", 180)

var TILE_SIZE: int = 16

var MOVE_VELOCITY: float = 100.0
var JUMP_VELOCITY: float = 250.0
var ACCELERATION: float = 10.0

var GROUP_NAME_PLAYER: StringName = "Player"
var GROUP_NAME_ITEMS: StringName = "Items"
var GROUP_NAME_ENEMIES: StringName = "Enemies"

var DEBUG: bool = false
