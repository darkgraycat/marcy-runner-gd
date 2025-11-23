class_name VariableModStatusEffect extends StatusEffectResource


@export var variable: Variables.VarName
@export var amount: float




func on_apply(status_effect_component: StatusEffectComponent) -> void:
	Variables.mod_state(variable, amount)
	status_effect_component.destroy_status_effect(self)


func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass


func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass


