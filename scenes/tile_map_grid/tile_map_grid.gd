@tool
class_name TileMapGrid extends Node2D

# variables #-------------------------------------------------------------------
@export var grid_size: Vector2i = Vector2i(4, 4):
	set(v): grid_size = v; _hint_update()
@export var cell_size: Vector2i = Vector2i(128, 128):
	set(v): cell_size = v; _hint_update()

@onready var color_rect: ColorRect = $ColorRect
var _tile_map_layers: Array[TileMapLayer] = []
var _tile_map_patterns: Dictionary[String, Array] = {}

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	if Engine.is_editor_hint(): return

	color_rect.hide()

	for node: Node in get_children():
		if not node is TileMapLayer: continue
		_tile_map_layers.append(node)

	for layer in _tile_map_layers:
		_tile_map_patterns[layer.name] = _extract_layer_patterns(layer)
		layer.clear()

# method #----------------------------------------------------------------------
func apply_pattern_at(idx: int, pos: Vector2i) -> void:
	for tile_map in _tile_map_layers:
		var chunk_size := cell_size / tile_map.tile_set.tile_size
		var pattern: TileMapPattern = _tile_map_patterns.get(tile_map.name, []).get(idx)
		if !pattern: continue
		tile_map.set_pattern(pos * chunk_size, pattern)

# method #----------------------------------------------------------------------
func get_patterns_amount() -> int:
	return (0 if _tile_map_layers.is_empty()
		else _tile_map_patterns[_tile_map_layers[0].name].size())

# method #----------------------------------------------------------------------
func _extract_layer_patterns(tile_map: TileMapLayer) -> Array[TileMapPattern]:
	var patterns: Array[TileMapPattern] = []
	var chunk_size := cell_size / tile_map.tile_set.tile_size
	for y in grid_size.y:
		for x in grid_size.x:
			var start_pos := Vector2i(x, y) * chunk_size
			var coords := Utils.get_recti_coords(Rect2i(start_pos, chunk_size))
			patterns.append(tile_map.get_pattern(coords))
	return patterns

# callback #--------------------------------------------------------------------
func _hint_update() -> void:
	if not is_node_ready(): await ready
	var shader: ShaderMaterial = color_rect.material
	var rect_size: Vector2i = grid_size * cell_size
	color_rect.size = rect_size
	shader.set_shader_parameter("rect_size", rect_size)
	shader.set_shader_parameter("cell_size", cell_size)
