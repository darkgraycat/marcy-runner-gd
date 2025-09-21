class_name HealthModStatusEffect extends StatusEffectResource

# variables #-------------------------------------------------------------------
@export var amount: float = 1
# TODO: is not used
@export var damage_type: G.HealthModType = G.HealthModType.GENERIC

# builtin #---------------------------------------------------------------------

# method #----------------------------------------------------------------------
func on_apply(status_effect_component: StatusEffectComponent) -> void:
	var health_component: HealthComponent = status_effect_component.get_component(HealthComponent)
	if !health_component: return
	if amount < 0: health_component.damage(-amount)
	else: health_component.heal(amount)

# method #----------------------------------------------------------------------
func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass

# callback #--------------------------------------------------------------------
