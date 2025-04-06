class_name Background extends Node2D

@onready var sky_color_rect: ColorRect = $SkyCanvasLayer/SkyColorRect
@onready var sun_sprite_2d: Sprite2D = $SkyCanvasLayer/SunSprite2D

@onready var background_row_0: BackgroundRow = $BackgroundRow0
@onready var background_row_1: BackgroundRow = $BackgroundRow1
@onready var background_row_2: BackgroundRow = $BackgroundRow2
@onready var background_row_3: BackgroundRow = $BackgroundRow3
@onready var background_row_4: BackgroundRow = $BackgroundRow4

func set_params(params: BackgroundParams) -> void:
	sky_color_rect.color = params.sky_color
	background_row_0.from_params(params.background_row0)
	background_row_1.from_params(params.background_row1)
	background_row_2.from_params(params.background_row2)
	background_row_3.from_params(params.background_row3)
	background_row_4.from_params(params.background_row4)
