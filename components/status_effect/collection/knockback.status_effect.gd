class_name KnockbackStatusEffect extends StatusEffectResource


@export var knockback_force: Vector2 = Vector2.ZERO


func _ready() -> void:
	pass


func on_apply(status_effect_component: StatusEffectComponent) -> void:
	status_effect_component.parent.velocity += knockback_force


func on_destroy(_status_effect_component: StatusEffectComponent) -> void:
	pass


func on_update(_delta: float, _status_effect_component: StatusEffectComponent) -> void:
	pass


