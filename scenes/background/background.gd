class_name Background extends Node2D

@onready var sky_color_rect: ColorRect = $SkyCanvasLayer/SkyColorRect
@onready var sun_sprite_2d: Sprite2D = $SkyCanvasLayer/SunSprite2D
@onready var rows: Array[BackgroundRow] = [
	$BackgroundRow0,
	$BackgroundRow1,
	$BackgroundRow2,
	$BackgroundRow3,
	$BackgroundRow4,
]

func set_params(params: BackgroundParams) -> void:
	sky_color_rect.color = params.sky_color
	for idx in rows.size():
		rows[idx].from_params(params.rows[idx])
