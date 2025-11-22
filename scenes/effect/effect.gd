class_name Effect extends Node
signal effect_applied(effect: Effect)
signal effect_destroyed(effect: Effect)

# variables #-------------------------------------------------------------------
@export var resource: EffectResource

# method #----------------------------------------------------------------------
func apply(node: Node) -> void:
	effect_applied.emit(self)
	resource.on_apply(self, node)

# method #----------------------------------------------------------------------
func destroy(node: Node) -> void:
	effect_destroyed.emit(self)
	resource.on_destroy(self, node)
