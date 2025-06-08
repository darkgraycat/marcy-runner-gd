class_name TileMapChunkManager extends Node2D

@export var tile_map_chunk_grid: TileMapChunkGrid

var tilemap_layers: Array[TileMapLayer] = []
var tilemap_patterns: Dictionary = {}

func _ready() -> void:
	if not tile_map_chunk_grid:
		push_error("TileMapChunkGrid is required")
		return

	for node: Node2D in get_children():
		if not node is TileMapLayer: continue
		tilemap_layers.append(node)

	for layer: TileMapLayer in tilemap_layers:
		tilemap_patterns[layer.name] = tile_map_chunk_grid.get_tilemap_layer_patterns(layer)
		layer.clear()


func apply_pattern(idx: int, pos: Vector2i) -> void:
	for layer: TileMapLayer in tilemap_layers:
		var pattern: TileMapPattern = tilemap_patterns.get(layer.name)[idx]
		var chunk_size := tile_map_chunk_grid.get_tilemap_layer_chunk_size(layer)
		layer.set_pattern(pos * chunk_size, pattern)
