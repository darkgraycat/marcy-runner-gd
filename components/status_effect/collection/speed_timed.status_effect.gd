class_name SpeedTimedStatusEffect extends StatusEffectResource


@export var duration_sec: float = 10
@export var amount: float = 25




func on_apply(status_effect_component: StatusEffectComponent) -> void:
	var bonus_speed_component: BonusSpeedComponent = status_effect_component.get_component(BonusSpeedComponent)
	if !bonus_speed_component: return
	# bonus_speed_component.inc_bonus_speed(amount)
	Utils.log("Applying %s, old BS %s" % [amount, bonus_speed_component.bonus_speed])
	bonus_speed_component.bonus_speed += amount

	await Utils.sleep(duration_sec)
	if is_instance_valid(status_effect_component):
		status_effect_component.destroy_status_effect(self)


func on_destroy(status_effect_component: StatusEffectComponent) -> void:
	var bonus_speed_component: BonusSpeedComponent = status_effect_component.get_component(BonusSpeedComponent)
	if !bonus_speed_component: return
	# bonus_speed_component.dec_bonus_speed(amount)
	Utils.log("Removing %s, old BS %s" % [amount, bonus_speed_component.bonus_speed])
	bonus_speed_component.bonus_speed -= amount


func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass


