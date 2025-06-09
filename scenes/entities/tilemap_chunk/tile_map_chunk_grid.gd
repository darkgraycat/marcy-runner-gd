@tool
class_name TileMapChunkGrid extends Node2D

@export_group("Dimensions")
## Size of each tile in pixels (width x height)
@export var tile_size: Vector2i = Vector2i(16, 16):
	set(v): tile_size = v; _sync_dimensions()
## Number of tiles in each chunk (width x height)
@export var chunk_size: Vector2i = Vector2i(8, 8):
	set(v): chunk_size = v; _sync_dimensions()
## Number of chunks in the grid (horizontal x vertical)
@export var grid_size: Vector2i = Vector2i(4, 4):
	set(v): grid_size = v; _sync_dimensions()

@export_group("Visuals")
## Color for odd chunks
@export var grid_color_odd: Color = Color(0.5, 0.5, 0.2, 0.3):
	set(v): grid_color_odd = v; _sync_visuals()
## Color for even chunks
@export var grid_color_even: Color = Color(0.2, 0.5, 0.5, 0.3):
	set(v): grid_color_even = v; _sync_visuals()
## Color for line separators
@export var grid_line_color: Color = Color(0.2, 0.2, 0.2, 0.5):
	set(v): grid_line_color = v; _sync_visuals()
## Width of line separators
@export var grid_line_width: float = 1.0:
	set(v): grid_line_width = v; _sync_visuals()

@onready var color_rect: ColorRect = $ColorRect
@onready var shader: ShaderMaterial = color_rect.material

func _ready() -> void:
	if not Engine.is_editor_hint(): hide()
	_sync_dimensions()
	_sync_visuals()


func get_tilemap_layer_patterns(layer: TileMapLayer) -> Array[TileMapPattern]:
	var result: Array[TileMapPattern] = []
	var chunk_size := get_tilemap_layer_chunk_size(layer)
	for y: int in grid_size.y:
		for x: int in grid_size.x:
			var pos := Vector2i(x, y) * chunk_size
			var coords := recti_to_points(Rect2i(pos, chunk_size))
			result.append(layer.get_pattern(coords))
	return result


func get_tilemap_layer_chunk_size(layer: TileMapLayer) -> Vector2i:
	return (tile_size / layer.tile_set.tile_size) * chunk_size


func recti_to_points(rect: Rect2i) -> Array[Vector2i]:
	var coords: Array[Vector2i] = []
	for x in rect.size.x:
		for y in rect.size.y:
			coords.append(Vector2i(rect.position.x + x, rect.position.y + y))
	return coords


func _sync_dimensions() -> void:
	if not is_node_ready(): await ready
	var rect_size := grid_size * chunk_size * tile_size
	color_rect.size = rect_size
	shader.set_shader_parameter("tile_size", tile_size)
	shader.set_shader_parameter("chunk_size", chunk_size)
	shader.set_shader_parameter("rect_size", rect_size)

func _sync_visuals() -> void:
	shader.set_shader_parameter("primary_color", grid_color_odd)
	shader.set_shader_parameter("secondary_color", grid_color_even)
	shader.set_shader_parameter("line_color", grid_line_color)
	shader.set_shader_parameter("line_width", grid_line_width)
