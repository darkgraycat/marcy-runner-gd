@tool
class_name Background extends Node2D

@onready var sky_color_rect: ColorRect = %SkyColorRect
@onready var sun_sprite_2d: Sprite2D = %SunSprite2D
@onready var rows: Array[BackgroundRow] = [
	%BackgroundRow0,
	%BackgroundRow1,
	%BackgroundRow2,
	%BackgroundRow3,
	%BackgroundRow4,
]

func set_configuration(new_configuration: BackgroundConfig) -> void:
	sky_color_rect.modulate = new_configuration.sky_color

	sun_sprite_2d.modulate = new_configuration.sun_color
	sun_sprite_2d.frame = new_configuration.sun_frame
	sun_sprite_2d.position.y = new_configuration.sun_offset * Global.VIEWPORT_HEIGHT

	for idx in rows.size():
		var row: BackgroundRow = rows[idx]
		row.color = new_configuration["row%d_color" % idx]
		row.frame = new_configuration["row%d_frame" % idx]
		row.position.y = new_configuration["row%d_offset" % idx] * Global.VIEWPORT_HEIGHT
