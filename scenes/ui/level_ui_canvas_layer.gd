class_name LevelUiCanvasLayer extends CanvasLayer

# variables #-------------------------------------------------------------------
@onready var lifes_label: Label = %LifesLabel
@onready var score_label: Label = %ScoreLabel
@onready var effects_label: Label = %EffectsLabel

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	V.updated.connect(_on_variables_updated)
	E.effects_updated.connect(_on_effects_updated)
	_on_variables_updated()
	_on_effects_updated(null)

# method #----------------------------------------------------------------------
func set_lifes_value(value: Variant) -> void:
	lifes_label.text = _make_int_label(value, S.INGAME_UI_LIFES)

# method #----------------------------------------------------------------------
func set_score_value(value: Variant) -> void:
	score_label.text = _make_int_label(value, S.INGAME_UI_SCORE)

# method #----------------------------------------------------------------------
func set_effects_value(value: Variant) -> void:
	effects_label.text = _make_int_label(value, S.INGAME_UI_BOOST)

# method #----------------------------------------------------------------------
func _make_int_label(value: Variant, pattern: String, default: int = 0) -> String:
	var label_value := str(int(value) if value != null else default)
	return pattern % [label_value]

# callback #--------------------------------------------------------------------
func _on_variables_updated() -> void:
	set_lifes_value(V.get_state(V.VarName.Lifes))
	set_score_value(V.get_state(V.VarName.Score))

func _on_effects_updated(status_effect_component: StatusEffectComponent) -> void:
	if !status_effect_component: return set_effects_value(0)

	var bonus_speed_component: BonusSpeedComponent = status_effect_component.get_component(BonusSpeedComponent)
	if !bonus_speed_component: return set_effects_value(0)

	set_effects_value(bonus_speed_component.bonus_speed)
