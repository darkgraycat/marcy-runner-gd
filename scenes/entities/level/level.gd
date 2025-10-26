class_name Level extends Node2D

# variables #-------------------------------------------------------------------
@export var config: LevelConfig: set = set_config
@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D
@onready var level_ui_canvas_layer: LevelUiCanvasLayer = %LevelUiCanvasLayer
@onready var tilemap_chunk_root: TileMapChunkRoot = $TileMapChunkRoot
@onready var parallax: Parallax = $Parallax

var _tilemap_chunk_idxs: Array[int] = [0]
var _tilemap_chunk_next: Vector2i = Vector2i(0, 0)
var _tilemap_prev_chunk_idx: int = -1

var _parallax_idx: int = -1

# builtin #---------------------------------------------------------------------
func _init() -> void:
	# moved into _init because Level.ready fired last
	Variables.set_state(Variables.VarName.Score, 0)
	Variables.set_state(Variables.VarName.Lifes, 9)

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	Events.player_died.connect(_on_player_died)
	player_camera.limit_bottom = Globals.VIEWPORT_HEIGHT
	_tilemap_chunk_idxs.assign(range(0, tilemap_chunk_root.get_total_chunks()))

	Utils.log("Loaded chunk ids", _tilemap_chunk_idxs)
	Utils.log("Px", config.parallax_resources)

# builtin #---------------------------------------------------------------------
func _physics_process(_delta: float) -> void:
	if (player):
		player.input_move = Input.get_axis("move_left", "move_right")
		player.input_jump = Input.is_action_pressed("jump")

		if player.global_position.y > Globals.VIEWPORT_HEIGHT + Globals.TILE_SIZE:
			player.die()

		if player.global_position.x > (_tilemap_chunk_next.x - 1) * 288:
			next_demo_tilemap_chunk()

# method #----------------------------------------------------------------------
func set_config(new_config: LevelConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready
	set_parallax_idx(_parallax_idx)

# method #----------------------------------------------------------------------
func next_tilemap_chunk() -> void:
	var chunk_idx: int = _tilemap_chunk_idxs.pick_random()
	if chunk_idx == _tilemap_prev_chunk_idx:
		chunk_idx = _tilemap_chunk_idxs.pick_random()

	_tilemap_prev_chunk_idx = chunk_idx;
	Utils.log("gen chunk %s at" % chunk_idx, int(player.global_position.x), _tilemap_chunk_next.x * 288)
	tilemap_chunk_root.apply_chunk_at(chunk_idx, _tilemap_chunk_next)
	_tilemap_chunk_next.x += 1

# method #----------------------------------------------------------------------
func next_demo_tilemap_chunk() -> void:
	var chunk_idx := _tilemap_prev_chunk_idx + 1;
	if chunk_idx >= _tilemap_chunk_idxs.size():
		chunk_idx = 0;

	_tilemap_prev_chunk_idx = chunk_idx;
	Utils.log("gen chunk %s at" % chunk_idx, int(player.global_position.x), _tilemap_chunk_next.x * 288)
	tilemap_chunk_root.apply_chunk_at(chunk_idx, _tilemap_chunk_next)
	_tilemap_chunk_next.x += 1

	if chunk_idx % 4 == 0:
		set_parallax_idx((_parallax_idx + 1) % config.parallax_resources.size())

# method #----------------------------------------------------------------------
func set_parallax_idx(idx: int) -> void:
	_parallax_idx = idx
	if not parallax.is_node_ready(): await parallax.ready
	parallax.configuration = config.parallax_resources[idx]

# callback #--------------------------------------------------------------------
func _on_player_died() -> void:
	player.respawn(Vector2(player.global_position.x, 0))

# callback #--------------------------------------------------------------------
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_action"):
		player.respawn(Vector2(player.global_position.x, 0))
