extends Node

var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var VIEWPORT_WIDTH: int = ProjectSettings.get_setting("display/window/size/viewport_width")
var VIEWPORT_HEIGHT: int = ProjectSettings.get_setting("display/window/size/viewport_height")

var DEFAULT_MOVE_VELOCITY: float = 100.0
var DEFAULT_JUMP_VELOCITY: float = 250.0
