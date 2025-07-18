class_name EffectTimedBoost extends EffectResource

enum BoostProp {
	Speed,
	JumpHeight,
	JumpAmount,
}

@export var type: BoostProp
@export var duration_sec: float

var _time_left: float = 0.0

func on_apply(_target: EffectReciever) -> void:
	_time_left = duration_sec


func on_process(target: EffectReciever, delta: float) -> void:
	Util.log("Process %s, d %s" % [_time_left, delta])
	_time_left -= delta
	if _time_left <= 0:
		target.destroy_effect(self)
