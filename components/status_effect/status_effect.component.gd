class_name StatusEffectComponent extends Component
signal status_effect_applied(status_effect: StatusEffectResource)
signal status_effect_destroyed(status_effect: StatusEffectResource)
# variables #-------------------------------------------------------------------
@export var movement_component: Movement

var _status_effects: Array[StatusEffectResource]

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	pass

# builtin #---------------------------------------------------------------------
func _process(delta: float) -> void:
	for status_effect in _status_effects:
		status_effect.on_update(delta, self)

# method #----------------------------------------------------------------------
func apply_status_effect(status_effect: StatusEffectResource) -> void:
	_status_effects.append(status_effect)
	status_effect.on_apply(self)
	status_effect_applied.emit(status_effect)

# method #----------------------------------------------------------------------
func destroy_status_effect(status_effect: StatusEffectResource) -> void:
	_status_effects.erase(status_effect)
	status_effect.on_destroy(self)
	status_effect_destroyed.emit(status_effect)

# callback #--------------------------------------------------------------------
