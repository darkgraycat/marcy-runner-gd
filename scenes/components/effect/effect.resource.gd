class_name EffectResource extends Resource

@export var name: String = "BaseEffect"
@export_multiline var description: String = ""
@export var value: float = 0

func on_apply(_target: EffectReciever) -> void:
	pass

func on_destroy(_target: EffectReciever) -> void:
	pass

func on_process(_target: EffectReciever, _delta: float) -> void:
	pass
