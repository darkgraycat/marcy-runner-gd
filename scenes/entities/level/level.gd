class_name Level extends Node2D

@export var config: LevelConfig: set = set_config

@onready var state_manager: StateManager = %StateManager
@onready var background: Background = %Background
@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D

@onready var tmcr: TileMapChunkRoot = $TileMapChunkRoot

func _ready() -> void:
	state_manager.state_updated.connect(_on_state_updated)
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


func _on_state_updated(m: StateManager) -> void:
	var bonus_speed: float = m.get_value("bonus_speed")
	if bonus_speed > 0: m.set_value("bonus_speed", bonus_speed - 1)

func _on_item_collected(item: Item) -> void:
	var effect_amount := item.get_effect_amount()
	match item.get_effect():
		# ItemConfig.ItemEffect.None: pass
		# ItemConfig.ItemEffect.Score: set_value("score", state.score + int(effect_amount))
		# ItemConfig.ItemEffect.BonusSpeed: set_value("bonus_speed", state.bonus_speed + effect_amount)
		# ItemConfig.ItemEffect.AdditionalLife: set_value("lifes", state.lifes + int(effect_amount))
		_: push_warning("unknown item effect %s" % item.get_effect())
