@abstract
class_name StatusEffectResource extends Resource

## Should be called only from `StatusEffectComponent`
@abstract
func on_apply(status_effect_component: StatusEffectComponent) -> void

## Should be called only from `StatusEffectComponent`
@abstract 
func on_destroy(status_effect_component: StatusEffectComponent) -> void

## Should be called only from `StatusEffectComponent`
@abstract 
func on_update(delta: float, status_effect_component: StatusEffectComponent) -> void
