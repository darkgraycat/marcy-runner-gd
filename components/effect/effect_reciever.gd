class_name EffectReciever extends Node

signal effect_applied(effect: EffectResource)
signal effect_destroyed(effect: EffectResource)

var _effects: Dictionary = {}

func _ready() -> void:
	for key: int in EffectResource.EffectType.values():
		_effects[key] = []


func apply_effect(effect: EffectResource) -> void:
	effect._on_apply(self)
	_effects[effect.type].append(effect)
	Util.log("Applied %s" % effect.name)
	effect_applied.emit(effect)


func destroy_effect(effect: EffectResource) -> void:
	effect._on_destroy(self)
	_effects[effect.type].erase(effect)
	Util.log("Destroyed %s" % effect.name)
	effect_destroyed.emit(effect)


func get_effects(type: EffectResource.EffectType) -> Array:
	return _effects[type]


func get_effects_sum(type: EffectResource.EffectType) -> float:
	var accum: float = 0.0
	for er: EffectResource in get_effects(type):
		accum += er.value
	return accum
