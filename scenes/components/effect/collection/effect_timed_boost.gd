class_name EffectTimedBoost extends EffectResource

@export var duration_sec: float

func _on_apply(target: EffectReciever) -> void:
	await target.get_tree().create_timer(duration_sec).timeout
	target.destroy_effect(self)
