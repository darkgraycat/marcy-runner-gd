class_name Level extends Node2D

@onready var background: Background = $Background
@onready var blocks: Node2D = $Blocks
@onready var player: Player = $Player
@onready var camera_2d: Camera2D = $Player/Camera2D

func _ready() -> void:
	camera_2d.limit_bottom = Global.VIEWPORT_HEIGHT

func _physics_process(_delta: float) -> void:
	player.input_move = Input.get_axis("move_left", "move_right")
	player.input_jump = Input.is_action_pressed("jump")

func set_params(params: LevelParams) -> void:
	background.set_params(params.background_params)
