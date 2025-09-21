class_name VariableModStatusEffect extends StatusEffectResource

# variables #-------------------------------------------------------------------
@export var variable: Variables.VariableKey
@export var amount: float

# builtin #---------------------------------------------------------------------

# method #----------------------------------------------------------------------
func on_apply(status_effect_component: StatusEffectComponent) -> void:
	Variables.mod_state(variable, amount)
	status_effect_component.destroy_status_effect(self)

# method #----------------------------------------------------------------------
func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass

# callback #--------------------------------------------------------------------
