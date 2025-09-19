class_name TimedBoostEffect extends EffectResource

@export var duration_sec: float

func _on_apply(effect_reciever: EffectReciever) -> void:
	Util.log("Timed applied")
	await effect_reciever.get_tree().create_timer(duration_sec).timeout
	Util.log("Timed elapsed")
	if is_instance_valid(effect_reciever):
		Util.log("Times destroy deffered call")
		effect_reciever.destroy_effect.call_deferred(self)

func _on_destroy(_effect_reciever: EffectReciever) -> void:
	pass
