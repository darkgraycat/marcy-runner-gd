class_name LevelUiCanvasLayer extends CanvasLayer

@onready var lifes_label: Label = %LifesLabel
@onready var score_label: Label = %ScoreLabel
@onready var effects_label: Label = %EffectsLabel

func _ready() -> void:
	pass#TODO

func set_lifes_value(value: Variant) -> void:
	lifes_label.text = Strings.INGAME_UI_LIFES % int(value)

func set_score_value(value: Variant) -> void:
	score_label.text = Strings.INGAME_UI_SCORE % int(value)

func set_effects_value(value: Variant) -> void:
	effects_label.text = Strings.INGAME_UI_BOOST % int(value)
