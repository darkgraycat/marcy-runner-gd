class_name World extends Node2D

@export var chunk_size: Vector2i = Vector2i(3, 5)

# @onready var level_blocks: TileMapLayer = $LevelTiles/TileMapLayerBlocks
@onready var editor_blocks: TileMapLayer = $EditorTiles/TileMapLayerBlocks

var chunks_cache: Array[TileMapPattern] = []
var level_blocks: TileMapLayer

func _ready() -> void:
	level_blocks = clone_tilemap_layer(editor_blocks)
	level_blocks.clear()
	add_child(level_blocks)

	chunks_cache = get_tilemap_patterns(editor_blocks, chunk_size)

	set_tilemap_pattern(level_blocks, chunks_cache[0], Vector2i(0, 0))
	set_tilemap_pattern(level_blocks, chunks_cache[1], Vector2i(3, 0))
	set_tilemap_pattern(level_blocks, chunks_cache[2], Vector2i(7, 0))


func get_tilemap_patterns(layer: TileMapLayer, chunk_size: Vector2i) -> Array[TileMapPattern]:
	var bounds := layer.get_used_rect()
	# prints("get used rect pos", bounds.position)
	# prints("get used rect size", bounds.size)
	var cols := bounds.size.x / chunk_size.x
	var rows := bounds.size.y / chunk_size.y
	# prints("cols/rows", cols, rows)
	var result: Array[TileMapPattern] = []
	for x: int in cols:
		for y: int in rows:
			var pos := Vector2i(x, y)
			var rect := Rect2i(pos * chunk_size, chunk_size + Vector2i.DOWN)
			result.append(layer.get_pattern(rect_to_coords_array(rect)))
	return result

func set_tilemap_pattern(layer: TileMapLayer, pattern: TileMapPattern, coords: Vector2i) -> void:
	layer.set_pattern(coords, pattern)

func rect_to_coords_array(rect: Rect2i) -> Array[Vector2i]:
	var coords: Array[Vector2i] = []
	for x in range(rect.size.x):
		for y in range(rect.size.y):
			coords.append(Vector2i(rect.position.x + x, rect.position.y + y))
	return coords

static func clone_tilemap_layer(source: TileMapLayer) -> TileMapLayer:
	var new_layer := TileMapLayer.new()
	new_layer.name = source.name
	new_layer.tile_set = source.tile_set
	new_layer.y_sort_enabled = source.y_sort_enabled
	new_layer.y_sort_origin = source.y_sort_origin
	new_layer.z_index = source.z_index
	new_layer.modulate = source.modulate
	return new_layer
