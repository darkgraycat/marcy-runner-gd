@tool
class_name Parallax extends Node2D

@export var screen_size: Vector2i = Vector2.ZERO
@export var source_sprite_2d: Sprite2D
@export var configuration: ParallaxResource: set = set_configuration

@onready var rows_root: Node2D = $RowsRoot
@onready var source_parallax_2d: Parallax2D = $SourceParallax2D

func set_configuration(value: ParallaxResource) -> void:
	configuration = value
	if not is_node_ready(): await ready
	if not source_sprite_2d: return push_error("Source Sprite2D is not defined")

	var source_frame_count := Vector2i(source_sprite_2d.hframes, source_sprite_2d.vframes)
	var source_frame_size := Vector2i(source_sprite_2d.texture.get_size()) / source_frame_count

	_clear_rows()
	for idx: int in configuration.total_rows:
		var row := _create_row(
			source_sprite_2d.texture,
			source_frame_size,
			configuration.frames[idx],
			configuration.colors[idx],
			configuration.offsets[idx],
		)
		rows_root.add_child(row, true)


func _create_row(
	texture: Texture,
	frame_size: Vector2i,
	frame:  int,
	color: Color,
	offset: float,
) -> Parallax2D:
	var row: Parallax2D = source_parallax_2d.duplicate()
	var sprite: Sprite2D = row.get_child(0)
	var color_rect: ColorRect = sprite.get_child(0)

	row.scroll_scale.x = offset
	row.scroll_offset.y = screen_size.y * offset
	row.visible = true
	sprite.texture = texture
	sprite.modulate = color
	sprite.region_rect = Rect2i(0, frame * frame_size.y, screen_size.x, frame_size.y)
	color_rect.size = Vector2i(screen_size.x, frame_size.y * 3)
	color_rect.position = Vector2i(0, frame_size.y)
	return row


func _clear_rows() -> void:
	for row: Parallax2D in rows_root.get_children():
		row.queue_free()


func _get_configuration_warnings() -> PackedStringArray:
	if not source_sprite_2d:
		return ["Source Sprite2D is not defined"]
	return []
