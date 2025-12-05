class_name Level extends Node2D


@export var config: LevelConfig: set = set_config
@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D
@onready var level_ui_canvas_layer: LevelUiCanvasLayer = %LevelUiCanvasLayer
@onready var tile_map_grid: TileMapGrid = $TileMapGrid
@onready var parallax: Parallax = $Parallax


var _tile_map_idxs: Array[int] = [0]
var _tile_map_next: Vector2i = Vector2i(0, 0)
var _tile_map_prev_idx: int = -1

var _parallax_idx: int = -1


func _ready() -> void:
	Events.player_died.connect(_on_player_died)
	player_camera.limit_bottom = Globals.VIEWPORT_HEIGHT
	_tile_map_idxs.assign(range(0, tile_map_grid.get_patterns_amount()))


func _physics_process(_delta: float) -> void:
	if (player):
		if player.global_position.y > Globals.VIEWPORT_HEIGHT + Globals.TILE_SIZE:
			player.die()

		if player.global_position.x > (_tile_map_next.x - 1) * 288:
			next_demo_tilemap_chunk()


func set_config(new_config: LevelConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready
	set_parallax_idx(_parallax_idx)


func next_tilemap_chunk() -> void:
	var chunk_idx: int = _tile_map_idxs.pick_random()
	if chunk_idx == _tile_map_prev_idx:
		chunk_idx = _tile_map_idxs.pick_random()

	_tile_map_prev_idx = chunk_idx;
	tile_map_grid.apply_pattern_at(chunk_idx, _tile_map_next)
	_tile_map_next.x += 1


func next_demo_tilemap_chunk() -> void:
	var chunk_idx := _tile_map_prev_idx + 1;
	if chunk_idx >= _tile_map_idxs.size():
		chunk_idx = 0;

	_tile_map_prev_idx = chunk_idx;
	tile_map_grid.apply_pattern_at(chunk_idx, _tile_map_next)
	_tile_map_next.x += 1

	if chunk_idx % 4 == 0:
		set_parallax_idx((_parallax_idx + 1) % config.parallax_resources.size())


func set_parallax_idx(idx: int) -> void:
	_parallax_idx = idx
	if not parallax.is_node_ready(): await parallax.ready
	parallax.configuration = config.parallax_resources[idx]


func _on_player_died() -> void:
	player.respawn(Vector2(player.global_position.x, 0))


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_action"):
		player.respawn(Vector2(player.global_position.x, 0))
