class_name BackgroundRow extends Node2D

const TILE_SIZE: int = 32

@export_range(0.0, 1.0, 0.1) var scroll_scale := 0.0

@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var sprite_2d: Sprite2D = $Parallax2D/Sprite2D

func _ready() -> void:
	parallax_2d.scroll_scale.x = scroll_scale

func from_params(params: BackgroundRowParams) -> void:
	sprite_2d.region_rect.position.y = params.frame * TILE_SIZE
	position.y = params.offset * Global.VIEWPORT_HEIGHT
	modulate = params.color
