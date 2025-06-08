class_name Level extends Node2D

@export var config: LevelConfig: set = set_config

@onready var background: Background = %Background
@onready var level_chunks_root: Node2D = %LevelChunksRoot
@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D

@onready var tmcm: TileMapChunkManager = $TileMapChunkManager

var level_chunks: Array[LevelChunk] = []
var next_chunk_x: float = 0.0

func _ready() -> void:
	for level_chunk: LevelChunk in level_chunks_root.get_children():
		level_chunks.append(level_chunk)
		level_chunk.set_config(config.level_chunk_variations[0])
		level_chunk.screen_exited.connect(on_level_chunk_exited)
		next_chunk_x = maxf(level_chunk.get_right_x(), next_chunk_x)
		prints("next x", next_chunk_x)

	player_camera.limit_bottom = Global.VIEWPORT_HEIGHT

	tmcm.apply_pattern(4, Vector2i(0, 0))
	tmcm.apply_pattern(3, Vector2i(0, 1))
	tmcm.apply_pattern(0, Vector2i(1, 0))
	tmcm.apply_pattern(2, Vector2i(2, 0))


func _physics_process(_delta: float) -> void:
	player.input_move = Input.get_axis("move_left", "move_right")
	player.input_jump = Input.is_action_pressed("jump")


func set_config(new_config: LevelConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready


func on_level_chunk_exited(level_chunk: LevelChunk) -> void:
	level_chunk.set_config(Util.pick_random_element(config.level_chunk_variations))
	level_chunk.position.x = next_chunk_x
	next_chunk_x = level_chunk.get_right_x()
	prints("next x", next_chunk_x)
