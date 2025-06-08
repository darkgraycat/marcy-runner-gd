class_name TileMapChunkManager extends Node2D

## Size in pixels of the base tile
@export var tile_size: Vector2i = Vector2i(48, 32)
## Size in tiles of chunk
@export var chunk_size: Vector2i = Vector2i(2, 4)
## Size in chunks of grid
@export var grid_size: Vector2i = Vector2i(3, 2)

@export var tile_map_chunk_editor_hint: TileMapChunkEditorHint

var tilemap_layers: Array[TileMapLayer] = []
var tilemap_patterns: Dictionary = {}

func _ready() -> void:
	for node: Node2D in get_children():
		if not node is TileMapLayer: continue
		tilemap_layers.append(node)

	for layer: TileMapLayer in tilemap_layers:
		var pattern := get_tilemap_patterns(layer)
		tilemap_patterns[layer.name] = pattern
		layer.clear()

	prints(
		tile_map_chunk_editor_hint.chunks_per_grid,
		tile_map_chunk_editor_hint.pixels_per_tile,
		tile_map_chunk_editor_hint.tiles_per_chunk
	)


func get_total_chunks() -> int:
	return grid_size.x * grid_size.y


func apply_pattern(idx: int, pos: Vector2i) -> void:
	for layer: TileMapLayer in tilemap_layers:
		var pattern: TileMapPattern = tilemap_patterns.get(layer.name)[idx]
		var t_scale := get_layer_tile_scale(layer)
		layer.set_pattern(pos * t_scale, pattern)


func get_tilemap_patterns(layer: TileMapLayer) -> Array[TileMapPattern]:
	var result: Array[TileMapPattern] = []
	var t_scale := get_layer_tile_scale(layer)
	for y: int in grid_size.y:
		for x: int in grid_size.x:
			var pos := Vector2i(x, y) * t_scale
			var coords := rect_to_coords_array(Rect2i(pos, t_scale))
			result.append(layer.get_pattern(coords))
	return result


func get_layer_tile_scale(layer: TileMapLayer) -> Vector2i:
	return (tile_size / layer.tile_set.tile_size) * chunk_size


func rect_to_coords_array(rect: Rect2i) -> Array[Vector2i]:
	var coords: Array[Vector2i] = []
	for x in rect.size.x:
		for y in rect.size.y:
			coords.append(Vector2i(rect.position.x + x, rect.position.y + y))
	return coords
