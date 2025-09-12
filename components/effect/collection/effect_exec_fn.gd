class_name EffectExecFn extends EffectResource

@export var fn_name: StringName
@export var fn_args: Array

func _on_apply(effect_reciever: EffectReciever) -> void:
	var target: Node2D = effect_reciever.get_parent()
	if target and target.has_method(fn_name):
		await target.call(fn_name, fn_args)
	effect_reciever.destroy_effect.call_deferred(self)
