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
	lifes_label.text = str(State.get_state(State.StateKey.Lifes))
	score_label.text = str(State.get_state(State.StateKey.Score))

func update_effects(effect_reciever: EffectReciever) -> void:
	if not effect_reciever:
		effects_label.text = "0"
		return

	var speed_buff: float = effect_reciever.get_effects_sum(EffectResource.EffectType.Speed)
	effects_label.text = str(speed_buff)
