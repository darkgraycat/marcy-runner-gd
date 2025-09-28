class_name InvincibilityStatusEffect extends StatusEffectResource

# variables #-------------------------------------------------------------------
@export var duration_sec: float = 30

# builtin #---------------------------------------------------------------------

# method #----------------------------------------------------------------------
func on_apply(status_effect_component: StatusEffectComponent) -> void:
	var health_component: HealthComponent = status_effect_component.get_component(HealthComponent)
	if !health_component: return
	health_component.set_invincibility_time_sec(duration_sec)

# method #----------------------------------------------------------------------
func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass

# callback #--------------------------------------------------------------------
