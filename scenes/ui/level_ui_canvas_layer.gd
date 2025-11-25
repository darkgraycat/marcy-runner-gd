class_name LevelUiCanvasLayer extends CanvasLayer

@onready var lifes_label: Label = %LifesLabel
@onready var score_label: Label = %ScoreLabel
@onready var effects_label: Label = %EffectsLabel


func _ready() -> void:
	Variables.updated.connect(_on_variables_updated)
	Events.effects_updated.connect(_on_effects_updated)
	Events.player_attr_updated.connect(func(key: String, value: float) -> void:
		if key == AttrPlayer.Key.Health: set_lifes_value(value))

	_on_variables_updated()
	_on_effects_updated(null)


func set_lifes_value(value: Variant) -> void:
	lifes_label.text = _make_int_label(value, Strings.INGAME_UI_LIFES)


func set_score_value(value: Variant) -> void:
	score_label.text = _make_int_label(value, Strings.INGAME_UI_SCORE)


func set_effects_value(value: Variant) -> void:
	effects_label.text = _make_int_label(value, Strings.INGAME_UI_BOOST)


func _make_int_label(value: Variant, pattern: String, default: int = 0) -> String:
	var label_value := str(int(value) if value != null else default)
	return pattern % [label_value]


func _on_variables_updated() -> void:
	#set_lifes_value(Variables.get_state(Variables.VarName.Lifes))
	set_score_value(Variables.get_state(Variables.VarName.Score))

func _on_effects_updated(status_effect_component: StatusEffectComponent) -> void:
	if !status_effect_component: return set_effects_value(0)

	var bonus_speed_component: BonusSpeedComponent = status_effect_component.get_component(BonusSpeedComponent)
	if !bonus_speed_component: return set_effects_value(0)

	set_effects_value(bonus_speed_component.bonus_speed)
