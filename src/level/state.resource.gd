class_name StateResource extends Resource

@export_group("Player")
@export var player_move_velocity: float = 100
@export var player_jump_velocity: float = 250
@export var player_bonus_speed: float = 0
@export var player_max_jumps: int = 1
@export var player_invincible: bool = false

@export_group("State")
@export var score_points: int = 0
@export var lifes_amount: int = 3
@export var max_lifes_amount: int = 9

