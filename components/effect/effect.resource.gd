@abstract
class_name EffectResource extends Resource

enum EffectType {
	Score,
	Lifes,
	Speed,
	JumpHeight,
	JumpAmount,
	JumpBounce,
	Invulnerability,
}

@export var name: String = "BaseEffect"
@export_multiline var description: String = ""
@export var value: float = 0
@export var type: EffectType

@abstract
func _on_apply(_effect_reciever: EffectReciever) -> void

@abstract
func _on_destroy(_effect_reciever: EffectReciever) -> void
