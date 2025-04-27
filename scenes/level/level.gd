class_name Level extends Node2D

@onready var background: Background = %Background
@onready var blocks_root: Node2D = %BlocksRoot
@onready var block_generator: BlockGenerator = %BlockGenerator
@onready var player: Player = %Player
@onready var player_camera: Camera2D = %Player/Camera2D


# var block_entities: Array[Block] = []
# var block_generator: Generator.BlockHeight

func _ready() -> void:
	# for node: Block in blocks_root.get_children():
	# 	block_entities.append(node)

	# blocks_root.get_children().map(block_entities.append)

	player_camera.limit_bottom = Global.VIEWPORT_HEIGHT
	# block_generator = Generator.BlockHeight.new([2, 5], [1, 5], [3, 1])

# TODO: deprecate
# func _process(_delta: float) -> void:
# 	var offset_x: int = block_entities.size() * 48
# 	for block: Block in block_entities:
# 		if block.visible: continue
# 		# if block.is_offscreen(player_camera): continue
# 		var row: float = block_generator.next() - 0.5
# 		# TODO: continue work here
# 		# Maybe try visibility_changed signal
# 		block.global_position.x += offset_x
# 		block.global_position.y = Global.VIEWPORT_HEIGHT - row * 32
# 		block.visible = true
# 		block.randomize()

func _physics_process(_delta: float) -> void:
	player.input_move = Input.get_axis("move_left", "move_right")
	player.input_jump = Input.is_action_pressed("jump")

# TODO: deprecate
# func set_params(params: LevelParams) -> void:
# 	# background.set_params(params.background_params)
# 	blocks_root.modulate = params.blocks_color
