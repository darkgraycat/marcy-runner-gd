@abstract
class_name EffectResource extends Resource


@export var name: StringName


@abstract
func on_apply(effect: Effect, node: Node) -> void


@abstract
func on_destroy(effect: Effect, node: Node) -> void
