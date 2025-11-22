@abstract
class_name StatusEffectResource extends Resource

# variables #-------------------------------------------------------------------
@export var name: StringName

# builtin #---------------------------------------------------------------------
func _init() -> void:
	resource_local_to_scene = true

# method #----------------------------------------------------------------------
## Should be called only from `StatusEffectComponent`
@abstract
func on_apply(status_effect_component: StatusEffectComponent) -> void

# method #----------------------------------------------------------------------
## Should be called only from `StatusEffectComponent`
@abstract
func on_destroy(status_effect_component: StatusEffectComponent) -> void

# method #----------------------------------------------------------------------
## Should be called only from `StatusEffectComponent`
@abstract
func on_update(delta: float, status_effect_component: StatusEffectComponent) -> void
