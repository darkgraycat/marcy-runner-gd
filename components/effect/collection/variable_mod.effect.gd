class_name VariableModEffect extends EffectResource

func _on_apply(effect_reciever: EffectReciever) -> void:
	match type:
		EffectResource.EffectType.Score: Variables.mod_state(Variables.VariableKey.Score, int(value))
		EffectResource.EffectType.Lifes: Variables.mod_state(Variables.VariableKey.Lifes, int(value))
		_: pass
	effect_reciever.destroy_effect.call_deferred(self)


func _on_destroy(_effect_reciever: EffectReciever) -> void:
	pass
