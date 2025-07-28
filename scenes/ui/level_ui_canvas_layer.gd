class_name LevelUiCanvasLayer extends CanvasLayer

@onready var lifes_label: Label = %LifesLabel
@onready var score_label: Label = %ScoreLabel
@onready var effects_label: Label = %EffectsLabel

func _ready() -> void:
	State.updated.connect(update_labels)
	Events.effects_updated.connect(update_effects)
	update_labels()
	update_effects(null)


func update_labels() -> void:
	var lifes: Variant = State.get_state(State.StateKey.Lifes)
	var score: Variant = State.get_state(State.StateKey.Score)
	lifes_label.text = str(int(lifes) if lifes != null else 0)
	score_label.text = str(int(score) if score != null else 0)
	#lifes_label.text = str(State.get_state(State.StateKey.Lifes) or 0)
	#score_label.text = str(State.get_state(State.StateKey.Score) or 0)

func update_effects(effect_reciever: EffectReciever) -> void:
	if not effect_reciever:
		effects_label.text = "0"
		return

	var speed_buff: float = effect_reciever.get_effects_sum(EffectResource.EffectType.Speed)
	effects_label.text = str(int(speed_buff))
