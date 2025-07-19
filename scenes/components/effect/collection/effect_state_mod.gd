class_name EffectStateMod extends EffectResource

func _on_apply(target: EffectReciever) -> void:
	match type:
		EffectResource.EffectType.Score: State.mod_state(State.StateKey.Score, int(value))
		EffectResource.EffectType.Lifes: State.mod_state(State.StateKey.Lifes, int(value))
		_: pass
	target.destroy_effect(self)
