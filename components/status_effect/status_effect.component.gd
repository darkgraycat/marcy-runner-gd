class_name StatusEffectComponent extends Component
signal status_effect_applied(status_effect: StatusEffectResource)
signal status_effect_destroyed(status_effect: StatusEffectResource)

# variables #-------------------------------------------------------------------
@export var movement_component: MovementComponent
@export var health_component: HealthComponent

var _status_effects: Array[StatusEffectResource]

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	Util.validate_error_pairs(parent,
		[!movement_component, "MovementComponent is not defined"],
		[!health_component, "HealthComponent is not defined"],
	)
	if !movement_component: return push_warning(parent, "MovementComponent is not defined")
	if !health_component: return  push_warning(parent, "HealthComponent is not defined")

# builtin #---------------------------------------------------------------------
func _process(delta: float) -> void:
	for status_effect in _status_effects:
		status_effect.on_update(delta, self)

# method #----------------------------------------------------------------------
static func get_from(
	from: Node,
	property: String = "status_effect_component"
) -> StatusEffectComponent:
	return Component.get_component(from, property, StatusEffectComponent)

# method #----------------------------------------------------------------------
func apply_status_effect(status_effect: StatusEffectResource) -> void:
	_status_effects.append(status_effect)
	status_effect.on_apply(self)
	status_effect_applied.emit(status_effect)

# method #----------------------------------------------------------------------
func apply_status_effects(status_effects: Array[StatusEffectResource]) -> void:
	for effect: StatusEffectResource in status_effects:
		apply_status_effect(effect)

# method #----------------------------------------------------------------------
func destroy_status_effect(status_effect: StatusEffectResource) -> void:
	_status_effects.erase(status_effect)
	status_effect.on_destroy(self)
	status_effect_destroyed.emit(status_effect)

# callback #--------------------------------------------------------------------
