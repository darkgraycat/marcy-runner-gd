class_name LevelUiCanvasLayer extends CanvasLayer

@export var state_manager: StateManager

@onready var lifes_label: Label = %LifesLabel
@onready var score_label: Label = %ScoreLabel
@onready var effects_label: Label = %EffectsLabel

func _ready() -> void:
	if !state_manager: return push_error("StateManager is not defined")
	state_manager.state_updated.connect(update_labels)
	update_labels(state_manager.state)


func update_labels(state: Dictionary) -> void:
	lifes_label.text = str(state.lifes)
	score_label.text = str(state.score)
	effects_label.text = str(state.bonus_speed)
