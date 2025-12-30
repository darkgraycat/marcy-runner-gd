class_name LevelUiCanvasLayer extends CanvasLayer

@onready var score_label: Label = %ScoreLabel
@onready var lifes_label: Label = %LifesLabel
@onready var effects_label: Label = %EffectsLabel

func set_score_value(value: Variant) -> void:
	score_label.text = Strings.INGAME_UI_SCORE % int(value)

func set_lifes_value(value: Variant) -> void:
	lifes_label.text = Strings.INGAME_UI_LIFES % int(value)

func set_effects_value(value: Variant) -> void:
	effects_label.text = Strings.INGAME_UI_BOOST % int(value)

func update_labels(state: StateResource) -> void:
	set_score_value(state.score_points)
	set_lifes_value(state.lifes_amount)
	set_effects_value(state.player_bonus_speed)
