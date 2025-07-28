class_name EffectTimedBoost extends EffectResource

@export var duration_sec: float

func _on_apply(effect_reciever: EffectReciever) -> void:
	await effect_reciever.get_tree().create_timer(duration_sec).timeout
	effect_reciever.destroy_effect(self)
