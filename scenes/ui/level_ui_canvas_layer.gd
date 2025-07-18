class_name LevelUiCanvasLayer extends CanvasLayer

@onready var lifes_label: Label = %LifesLabel
@onready var score_label: Label = %ScoreLabel
@onready var effects_label: Label = %EffectsLabel

func _ready() -> void:
	State.updated.connect(update_labels)
	update_labels()


func update_labels() -> void:
	prints("Update labels")
	lifes_label.text = str(State.get_state(State.StateKey.Lifes))
	score_label.text = str(State.get_state(State.StateKey.Score))
	effects_label.text = str("Not implemented")
