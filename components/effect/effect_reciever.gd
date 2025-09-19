class_name EffectReciever extends Node

signal effect_applied(effect: EffectResource)
signal effect_destroyed(effect: EffectResource)

var _effects: Dictionary = {}

func _ready() -> void:
	for key: int in EffectResource.EffectType.values():
		_effects[key] = []


func apply_effect(effect: EffectResource) -> void:
	_effects[effect.type].append(effect)
	effect._on_apply(self)
	effect_applied.emit(effect)
	Util.log("+ %s" % effect.name)
	Events.emit_debug_message("%s" % _effects[2].size(), 2)


func destroy_effect(effect: EffectResource) -> void:
	_effects[effect.type].erase(effect)
	effect._on_destroy(self)
	effect_destroyed.emit(effect)
	Util.log("- %s" % effect.name)
	Events.emit_debug_message("%s" % _effects[2].size(), 2)


func get_effects(type: EffectResource.EffectType) -> Array:
	return _effects[type]


func sum_effects(type: EffectResource.EffectType) -> float:
	var accum: float = 0.0
	for er: EffectResource in get_effects(type):
		accum += er.value
	return accum
