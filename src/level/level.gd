class_name Level extends Node2D

@export var config: LevelResource

@onready var player: Player = $Player
@onready var player_camera: Camera2D = $Player/Camera2D

@onready var tile_grid: TileGrid = $TileGrid
@onready var parallax: Parallax = $Parallax

@onready var level_ui_canvas_layer: LevelUiCanvasLayer = $LevelUiCanvasLayer
@onready var level_bottom_area_2d: Area2D = $LevelBottomArea2D
@onready var level_side_area_2d: Area2D = $LevelSideArea2D

func _ready() -> void:
	player_camera.limit_bottom = Global.VIEWPORT_HEIGHT
	player.movement.max_speed = config.state.player_move_velocity
	player.jumping.jump_force = config.state.player_jump_velocity
	player.jumping.max_jumps = config.state.player_max_jumps

	if not parallax.is_node_ready(): await parallax.ready
	parallax.config = config.parallax;

	level_ui_canvas_layer.update_labels(config.state)

	tile_grid.apply_pattern_at(0, Vector2i(0, 0))
	tile_grid.apply_pattern_at(0, Vector2i(1, 0))
	level_side_area_2d.position.x = tile_grid.cell_size.x
	level_side_area_2d.body_entered.connect(_on_level_side_area_2d_body_entered)
	level_bottom_area_2d.body_entered.connect(_on_level_bottom_area_2d_body_entered)

	Events.player_died.connect(_on_player_died)
	Events.player_item_collected.connect(_on_player_item_collected)

func _on_player_died() -> void:
	await Util.sleep(1)
	player.respawn(Vector2(player.global_position.x - 64, 0))

func _on_player_item_collected(item: Node2D) -> void:
	if item is ItemPanacat: config.state.score_points += 10
	elif item is ItemBean: config.state.player_bonus_speed += 25
	elif item is ItemLife: config.state.lifes_amount += 1
	elif item is ItemSuperPanacat: print("SuperPanacat collected")
	level_ui_canvas_layer.update_labels(config.state)

func _on_level_bottom_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die.call_deferred()

func _on_level_side_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		level_side_area_2d.position.x += tile_grid.cell_size.x
		var next_grid_idx: int = config.grid_idxs.pick_random()
		var next_grid_pos := Vector2i(ceili(level_side_area_2d.position.x / tile_grid.cell_size.x), 0)
		tile_grid.apply_pattern_at(next_grid_idx, next_grid_pos)
