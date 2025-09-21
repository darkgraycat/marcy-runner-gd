class_name VariableModEffect extends EffectResource

func _on_apply(effect_reciever: EffectReciever) -> void:
	match type:
		EffectResource.EffectType.Score: V.mod_state(V.VarName.Score, int(value))
		EffectResource.EffectType.Lifes: V.mod_state(V.VarName.Lifes, int(value))
		_: pass
	effect_reciever.destroy_effect.call_deferred(self)


func _on_destroy(_effect_reciever: EffectReciever) -> void:
	pass
