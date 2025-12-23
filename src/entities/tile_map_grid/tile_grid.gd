@tool
class_name TileGrid extends Node2D

@export var grid_size: Vector2i = Vector2i(4, 4):
	set(v): grid_size = v; _hint_update()
@export var cell_size: Vector2i = Vector2i(128, 128):
	set(v): cell_size = v; _hint_update()

@onready var color_rect: ColorRect = $ColorRect

var _layers: Array[TileMapLayer] = []
var _patterns: Dictionary[String, Array] = {}

func _ready() -> void:
	if Engine.is_editor_hint(): return

	color_rect.hide()

	for node: Node in get_children():
		if not node is TileMapLayer: continue
		_layers.append(node)

	for layer in _layers:
		_patterns[layer.name] = _extract_layer_patterns(layer)
		layer.clear()

func apply_pattern_at(idx: int, pos: Vector2i) -> void:
	for tile_map in _layers:
		var chunk_size := cell_size / tile_map.tile_set.tile_size
		var pattern: TileMapPattern = _patterns.get(tile_map.name, []).get(idx)
		if !pattern: continue
		tile_map.set_pattern(pos * chunk_size, pattern)

func get_patterns_amount() -> int:
	return (0 if _layers.is_empty()
		else _patterns[_layers[0].name].size())

func _extract_layer_patterns(tile_map: TileMapLayer) -> Array[TileMapPattern]:
	var patterns: Array[TileMapPattern] = []
	var chunk_size := cell_size / tile_map.tile_set.tile_size
	for y in grid_size.y:
		for x in grid_size.x:
			var start_pos := Vector2i(x, y) * chunk_size
			var coords := Util.get_recti_coords(Rect2i(start_pos, chunk_size))
			patterns.append(tile_map.get_pattern(coords))
	return patterns

func _hint_update() -> void:
	if not is_node_ready(): await ready
	var shader: ShaderMaterial = color_rect.material
	var rect_size: Vector2i = grid_size * cell_size
	color_rect.size = rect_size
	shader.set_shader_parameter("rect_size", rect_size)
	shader.set_shader_parameter("cell_size", cell_size)
