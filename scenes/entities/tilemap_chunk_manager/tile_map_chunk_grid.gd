@tool
class_name TileMapChunkGrid extends Node2D

## Size of each tile in pixels (width x height)
@export var pixels_per_tile: Vector2i = Vector2i(16, 16):
	set(v): pixels_per_tile = v; _sync()

## Number of tiles in each chunk (width x height)
@export var tiles_per_chunk: Vector2i = Vector2i(8, 8):
	set(v): tiles_per_chunk = v; _sync()

## Number of chunks in the grid (horizontal x vertical)
@export var chunks_per_grid: Vector2i = Vector2i(4, 4):
	set(v): chunks_per_grid = v; _sync()

@onready var color_rect: ColorRect = $ColorRect
@onready var shader: ShaderMaterial = color_rect.material

func _ready() -> void:
	if not Engine.is_editor_hint(): hide()
	_sync()


func _sync() -> void:
	if not is_node_ready(): await ready
	var rect_size := chunks_per_grid * tiles_per_chunk * pixels_per_tile
	color_rect.size = rect_size
	shader.set_shader_parameter("pixels_per_tile", pixels_per_tile)
	shader.set_shader_parameter("tiles_per_chunk", tiles_per_chunk)
	shader.set_shader_parameter("rect_size", rect_size)


func get_tilemap_layer_patterns(layer: TileMapLayer) -> Array[TileMapPattern]:
	var result: Array[TileMapPattern] = []
	var chunk_size := get_tilemap_layer_chunk_size(layer)
	for y: int in chunks_per_grid.y:
		for x: int in chunks_per_grid.x:
			var pos := Vector2i(x, y) * chunk_size
			var coords := rect_to_coords_array(Rect2i(pos, chunk_size))
			result.append(layer.get_pattern(coords))
	return result


func get_tilemap_layer_chunk_size(layer: TileMapLayer) -> Vector2i:
	return (pixels_per_tile / layer.tile_set.tile_size) * tiles_per_chunk


func rect_to_coords_array(rect: Rect2i) -> Array[Vector2i]:
	var coords: Array[Vector2i] = []
	for x in rect.size.x:
		for y in rect.size.y:
			coords.append(Vector2i(rect.position.x + x, rect.position.y + y))
	return coords
