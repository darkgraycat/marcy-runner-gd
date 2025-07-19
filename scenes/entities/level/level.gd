class_name Level extends Node2D

@export var config: LevelConfig: set = set_config

@onready var background: Background = %Background
@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D

@onready var level_ui_canvas_layer: LevelUiCanvasLayer = %LevelUiCanvasLayer
@onready var tmcr: TileMapChunkRoot = $TileMapChunkRoot

func _ready() -> void:
	State.set_state(State.StateKey.Score, 0)
	State.set_state(State.StateKey.Lifes, 0)

	player_camera.limit_bottom = Global.VIEWPORT_HEIGHT

	var last_idx := tmcr.get_total_chunks() - 1
	for x in 20:
		tmcr.apply_chunk_at(randi_range(0, last_idx), Vector2i(x, 0))

func _physics_process(_delta: float) -> void:
	player.input_move = Input.get_axis("move_left", "move_right")
	player.input_jump = Input.is_action_pressed("jump")

	if player.global_position.y > Global.VIEWPORT_HEIGHT + Global.TILE_SIZE:
		player.global_position.y = 0


func set_config(new_config: LevelConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready
