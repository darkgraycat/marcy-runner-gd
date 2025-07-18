class_name EffectReciever extends Node

signal effect_applied(effect: EffectResource, target: EffectReciever)
signal effect_destroyed(effect: EffectResource, target: EffectReciever)

var effects: Array[EffectResource] = []

enum EffectType {
	BonusSpeed,
	BonusJumpHeight,
	BonusJumpAmount,
}

var _effects: Dictionary = {}

func _ready() -> void:
	for key: int in EffectType.values():
		_effects[key] = []

func _process(delta: float) -> void:
	for effect in effects:
		effect.on_process(self, delta)

func apply_effect(effect: EffectResource) -> void:
	effect.on_apply(self)
	effects.append(effect)	
	Util.log("Applied %s" % effect.name) 
	effect_applied.emit(effect, self)


func destroy_effect(effect: EffectResource) -> void:
	effect.on_destroy(self)
	effects.erase(effect)
	Util.log("Destroyed %s" % effect.name) 
	effect_destroyed.emit(effect, self)


func get_effects_by_type(type: EffectType) -> Array[EffectResource]:
	return _effects[type]


func get_effects(effect_name: String) -> Array[EffectResource]:
	return effects.filter(func(er: EffectResource) -> bool:
		return er.name == effect_name
	)
