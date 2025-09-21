class_name HealthModStatusEffect extends StatusEffectResource

# variables #-------------------------------------------------------------------
@export var amount: float = 1
# TODO: is not used
@export var damage_type: Global.HealthModType = Global.HealthModType.GENERIC

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	pass

# method #----------------------------------------------------------------------
func on_apply(status_effect_component: StatusEffectComponent) -> void:
	if !status_effect_component.health_component: return
	if amount < 0: status_effect_component.health_component.damage(-amount)
	else: status_effect_component.health_component.heal(amount)

# method #----------------------------------------------------------------------
func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass

# callback #--------------------------------------------------------------------
