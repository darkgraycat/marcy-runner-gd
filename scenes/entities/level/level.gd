class_name Level extends Node2D

# variables #-------------------------------------------------------------------
@export var config: LevelConfig: set = set_config
@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D
@onready var level_ui_canvas_layer: LevelUiCanvasLayer = %LevelUiCanvasLayer
@onready var tilemap_chunk_root: TileMapChunkRoot = $TileMapChunkRoot

var tilemap_chunk_idxs: Array[int] = [0]
var tilemap_chunk_next: Vector2i = Vector2i(0, 0)

# builtin #---------------------------------------------------------------------
func _init() -> void:
	# moved into _init because Level.ready fired last
	V.set_state(V.VarName.Score, 0)
	V.set_state(V.VarName.Lifes, 9)

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	E.player_died.connect(_on_player_died)
	player_camera.limit_bottom = G.VIEWPORT_HEIGHT
	tilemap_chunk_idxs.assign(range(
		0, tilemap_chunk_root.get_total_chunks() - 4))
	prints("Loaded chunk ids", tilemap_chunk_idxs)

# builtin #---------------------------------------------------------------------
func _physics_process(_delta: float) -> void:
	if (player):
		player.input_move = Input.get_axis("move_left", "move_right")
		player.input_jump = Input.is_action_pressed("jump")

		if player.global_position.y > G.VIEWPORT_HEIGHT + G.TILE_SIZE:
			player.die()

		if player.global_position.x > (tilemap_chunk_next.x - 1) * 288:
			next_tilemap_chunk()

# method #----------------------------------------------------------------------
func set_config(new_config: LevelConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready

# method #----------------------------------------------------------------------
func next_tilemap_chunk() -> void:
	prints("gen chunk at", int(player.global_position.x), tilemap_chunk_next.x * 288)
	var chunk_idx: int = tilemap_chunk_idxs.pick_random()
	tilemap_chunk_root.apply_chunk_at(chunk_idx, tilemap_chunk_next)
	tilemap_chunk_next.x += 1

# method #----------------------------------------------------------------------
func _do_stuff() -> void:
	pass

# callback #--------------------------------------------------------------------
func _on_player_died() -> void:
	player.respawn(Vector2(player.global_position.x, 0))
