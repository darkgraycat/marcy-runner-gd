@abstract
class_name EffectResource extends Resource

# variables #-------------------------------------------------------------------
@export var name: StringName

# callback #--------------------------------------------------------------------
@abstract
func on_apply(effect: Effect, node: Node) -> void

# callback #--------------------------------------------------------------------
@abstract
func on_destroy(effect: Effect, node: Node) -> void
