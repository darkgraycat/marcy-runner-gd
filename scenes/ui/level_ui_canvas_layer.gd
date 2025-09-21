class_name LevelUiCanvasLayer extends CanvasLayer

@onready var lifes_label: Label = %LifesLabel
@onready var score_label: Label = %ScoreLabel
@onready var effects_label: Label = %EffectsLabel

func _ready() -> void:
	Variables.updated.connect(_on_variables_updated)
	Events.effects_updated.connect(_on_effects_updated)
	_on_variables_updated()
	_on_effects_updated(null)


func _on_variables_updated() -> void:
	var lifes: Variant = Variables.get_state(Variables.VarName.Lifes)
	var score: Variant = Variables.get_state(Variables.VarName.Score)
	lifes_label.text = _make_int_label(lifes, Strings.INGAME_UI_LIFES)
	score_label.text = _make_int_label(score, Strings.INGAME_UI_SCORE)


func _on_effects_updated(effect_reciever: EffectReciever) -> void:
	if not effect_reciever:
		effects_label.text = _make_int_label(0, Strings.INGAME_UI_BOOST)
		return

	var speed_buff: float = effect_reciever.sum_effects(EffectResource.EffectType.Speed)
	effects_label.text = _make_int_label(speed_buff, Strings.INGAME_UI_BOOST)


func _make_int_label(value: Variant, pattern: String, default: int = 0) -> String:
	var label_value := str(int(value) if value != null else default)
	return pattern % [label_value]
