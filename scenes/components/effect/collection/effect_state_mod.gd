class_name EffectStateMod extends EffectResource

@export var type: State.StateKey

func on_apply(target: EffectReciever) -> void:
	State.incr_state(type, int(value))
	target.destroy_effect(self)
