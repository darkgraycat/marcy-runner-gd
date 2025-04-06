class_name Level extends Node2D

@onready var background: Background = $Background
@onready var blocks: Node2D = $Blocks
@onready var player: Player = $Player
@onready var camera_2d: Camera2D = $Player/Camera2D

var block_entities: Array[Block] = []
var block_generator: Generator.BlockHeight

func _ready() -> void:
	for node in blocks.get_children():
		block_entities.append(node as Block)

	camera_2d.limit_bottom = Global.VIEWPORT_HEIGHT
	block_generator = Generator.BlockHeight.new([2, 5], [1, 5], [3, 1])

func _process(_delta: float) -> void:
	var scroll_x := camera_2d.global_position.x - Global.VIEWPORT_WIDTH / 2.0
	var offset_x := block_entities.size() * Block.TILE_WIDTH
	for block in block_entities:
		if block.is_offscreen(scroll_x): continue
		var row := block_generator.next() - 0.5
		block.global_position.x += offset_x
		block.global_position.y = Global.VIEWPORT_HEIGHT - row * block.TILE_HEIGHT

func _physics_process(_delta: float) -> void:
	player.input_move = Input.get_axis("move_left", "move_right")
	player.input_jump = Input.is_action_pressed("jump")

func set_params(params: LevelParams) -> void:
	background.set_params(params.background_params)
	blocks.modulate = params.blocks_color
