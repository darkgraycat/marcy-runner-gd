class_name Level extends Node2D

@export var config: LevelConfig: set = set_config

@onready var background: Background = %Background
@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D

@onready var tmcm: TileMapChunkRoot = $TileMapChunkRoot

var next_chunk_x: float = 0.0

func _ready() -> void:
	player_camera.limit_bottom = Global.VIEWPORT_HEIGHT

	var last_idx := tmcm.get_total_chunks() - 1

	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(0, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(1, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(2, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(3, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(4, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(5, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(6, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(7, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(8, 0))
	tmcm.apply_chunk_at(randi_range(0, last_idx), Vector2i(9, 0))


func _physics_process(_delta: float) -> void:
	player.input_move = Input.get_axis("move_left", "move_right")
	player.input_jump = Input.is_action_pressed("jump")


func set_config(new_config: LevelConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready
