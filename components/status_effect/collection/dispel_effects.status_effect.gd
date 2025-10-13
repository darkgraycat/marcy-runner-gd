class_name DispelEffectsStatusEffect extends StatusEffectResource

# variables #-------------------------------------------------------------------
@export var status_effect_type: Script

# builtin #---------------------------------------------------------------------

# method #----------------------------------------------------------------------
func on_apply(status_effect_component: StatusEffectComponent) -> void:
	var status_effects := status_effect_component.get_status_effects(status_effect_type)
	for status_effect in status_effects:
		status_effect_component.destroy_status_effect(status_effect)

# method #----------------------------------------------------------------------
func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass

# callback #--------------------------------------------------------------------
