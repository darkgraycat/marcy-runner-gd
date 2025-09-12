class_name EffectTimedBoost extends EffectResource

@export var duration_sec: float

func _on_apply(effect_reciever: EffectReciever) -> void:
	await effect_reciever.get_tree().create_timer(duration_sec).timeout
	if is_instance_valid(effect_reciever):
		effect_reciever.destroy_effect.call_deferred(self)
