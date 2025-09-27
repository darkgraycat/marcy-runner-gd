class_name SpeedTimedStatusEffect extends StatusEffectResource

# variables #-------------------------------------------------------------------
@export var duration_sec: float = 10
@export var amount: float = 25

# builtin #---------------------------------------------------------------------

# method #----------------------------------------------------------------------
func on_apply(status_effect_component: StatusEffectComponent) -> void:
	var movement_component := status_effect_component.get_component(MovementComponent)
	if !movement_component: return
	movement_component.target_speed += amount
	var timer := status_effect_component.get_tree().create_timer(duration_sec)
	await timer.timeout
	if is_instance_valid(status_effect_component):
		timer.free.call_deferred()
		status_effect_component.destroy_status_effect(self)

# method #----------------------------------------------------------------------
func on_destroy(status_effect_component: StatusEffectComponent) -> void:
	var movement_component := status_effect_component.get_component(MovementComponent)
	if !movement_component: return
	movement_component.target_speed -= amount

# method #----------------------------------------------------------------------
func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass

# callback #--------------------------------------------------------------------
