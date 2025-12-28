class_name Level extends Node2D

@export var config: LevelResource

@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D
@onready var level_ui_canvas_layer: LevelUiCanvasLayer = %LevelUiCanvasLayer
@onready var tile_grid: TileGrid = $TileGrid
@onready var parallax: Parallax = $Parallax

var _grid_next_position: Vector2i = Vector2i(-1, 0)

func _ready() -> void:
	Events.player_died.connect(_on_player_died)
	player_camera.limit_bottom = Global.VIEWPORT_HEIGHT
	if not parallax.is_node_ready(): await parallax.ready
	parallax.config = config.parallax;
	print("GSx %s" % tile_grid.cell_size.x);

func _physics_process(_delta: float) -> void:
	if (player):
		if player.global_position.y > Global.VIEWPORT_HEIGHT + Global.DEFAULT_TILE_SIZE:
			player.die()

		if player.global_position.x > _grid_next_position.x * tile_grid.cell_size.x:
			var grid_idx: int = config.grid_idxs.pick_random()
			_grid_next_position.x += 1
			tile_grid.apply_pattern_at(grid_idx, _grid_next_position)

func _on_player_died() -> void:
	player.respawn(Vector2(player.global_position.x, 0))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_action"):
		player.respawn(Vector2(player.global_position.x, 0))
