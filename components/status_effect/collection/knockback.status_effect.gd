class_name KnockbackStatusEffect extends StatusEffectResource

# variables #-------------------------------------------------------------------
@export var knockback_force: Vector2 = Vector2.ZERO

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	pass

# method #----------------------------------------------------------------------
func on_apply(status_effect_component: StatusEffectComponent) -> void:
	status_effect_component.parent.velocity += knockback_force

# method #----------------------------------------------------------------------
func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass

# callback #--------------------------------------------------------------------
