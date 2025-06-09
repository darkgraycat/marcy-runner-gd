class_name TileMapChunkRoot extends Node2D

## TileMapChunkGrid used to split tilemap into chunks
@export var tile_map_chunk_grid: TileMapChunkGrid

var tilemap_layers: Array[TileMapLayer] = []
var tilemap_patterns: Dictionary = {}

func _ready() -> void:
	if not tile_map_chunk_grid: return push_error("TileMapChunkGrid is not defined")

	for node: Node2D in get_children():
		if not node is TileMapLayer: continue
		tilemap_layers.append(node)

	for layer: TileMapLayer in tilemap_layers:
		tilemap_patterns[layer.name] = tile_map_chunk_grid.get_tilemap_layer_patterns(layer)
		layer.clear() # layers will be reused for placing patterns


func apply_chunk_at(idx: int, pos: Vector2i) -> void:
	for layer: TileMapLayer in tilemap_layers:
		var pattern: TileMapPattern = tilemap_patterns.get(layer.name)[idx]
		var chunk_size := tile_map_chunk_grid.get_tilemap_layer_chunk_size(layer)
		layer.set_pattern(pos * chunk_size, pattern)


func get_total_chunks() -> int:
	if tilemap_layers.is_empty(): return 0
	return tilemap_patterns[tilemap_layers[0].name].size()
