class_name Level extends Node2D

signal state_updated(state: StateResource)

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
	player.health.maximum = config.state.max_lifes_amount
	player.health.current = config.state.lifes_amount
	player.health.changed.connect(_on_player_hit)

	if not parallax.is_node_ready(): await parallax.ready
	parallax.config = config.parallax;

	level_ui_canvas_layer.update_labels(config.state)
	state_updated.connect(level_ui_canvas_layer.update_labels)

	tile_grid.apply_pattern_at(0, Vector2i(0, 0))
	tile_grid.apply_pattern_at(0, Vector2i(1, 0))
	level_side_area_2d.position.x = tile_grid.cell_size.x
	level_side_area_2d.body_entered.connect(_on_level_side_area_2d_body_entered)
	level_bottom_area_2d.body_entered.connect(_on_level_bottom_area_2d_body_entered)

	Events.player_item_collected.connect(_on_player_item_collected)

func _on_player_hit(value: float) -> void:
	config.state.lifes_amount = int(value)
	state_updated.emit(config.state)

func _on_player_item_collected(item: Node2D) -> void:
	var s := config.state
	if item is ItemPanacat:
		s.score_points += 10
	elif item is ItemBean:
		s.player_bonus_speed += 25
		player.movement.max_speed = s.player_move_velocity + s.player_bonus_speed
		state_updated.emit(s)
		await Util.sleep(5)
		s.player_bonus_speed -= 25
		if s.player_bonus_speed < 0:
			s.player_bonus_speed = 0
		player.movement.max_speed = s.player_move_velocity + s.player_bonus_speed
		state_updated.emit(s)
	elif item is ItemLife:
		player.health.current += 1
	elif item is ItemSuperPanacat:
		print("SuperPanacat collected")
	state_updated.emit(s)

func _on_level_bottom_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player.health.current -= 1
		player.die()
		await Util.sleep(1)
		player.respawn(Vector2(player.global_position.x - 64, 0))

func _on_level_side_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		level_side_area_2d.position.x += tile_grid.cell_size.x
		var next_grid_idx: int = config.grid_idxs.pick_random()
		var next_grid_pos := Vector2i(ceili(level_side_area_2d.position.x / tile_grid.cell_size.x), 0)
		tile_grid.apply_pattern_at(next_grid_idx, next_grid_pos)
