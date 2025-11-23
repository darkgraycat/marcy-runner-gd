class_name InvincibilityStatusEffect extends StatusEffectResource


@export var duration_sec: float = 30




func on_apply(status_effect_component: StatusEffectComponent) -> void:
	var health_component: HealthComponent = status_effect_component.get_component(HealthComponent)
	if !health_component: return
	health_component.set_invincibility_time_sec(duration_sec)
	await Utils.sleep(duration_sec)
	if is_instance_valid(status_effect_component):
		status_effect_component.destroy_status_effect(self)


func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass


func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass


