class_name EffectResource extends Resource

enum EffectType {
	Score,
	Lifes,
	Speed,
	JumpHeight,
	JumpAmount,
}

@export var name: String = "BaseEffect"
@export_multiline var description: String = ""
@export var value: float = 0
@export var type: EffectType

func _on_apply(_target: EffectReciever) -> void:
	pass

func _on_destroy(_target: EffectReciever) -> void:
	pass
