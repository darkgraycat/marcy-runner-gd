@tool
class_name BackgroundRow extends Node2D

@export var color: Color = Color.WHITE: set = set_color
@export var frame: int = 1: set = set_frame
@export var speed: float = 0.0

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var parallax_2d: Parallax2D = %Parallax2D

func _ready() -> void:
	_refresh()

func set_frame(new_frame: int) -> void:
	frame = new_frame
	_refresh()

func set_color(new_color: Color) -> void:
	color = new_color
	_refresh()

func _refresh() -> void:
	if not is_node_ready(): await ready
	sprite_2d.modulate = color
	sprite_2d.region_rect.position.y = frame * 32
	sprite_2d.region_filter_clip_enabled = true
	parallax_2d.scroll_scale.x = speed
