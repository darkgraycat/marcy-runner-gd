class_name StatusEffectComponent extends Component
signal status_effect_applied(status_effect: StatusEffectResource)
signal status_effect_destroyed(status_effect: StatusEffectResource)

# variables #-------------------------------------------------------------------
@export var components: Array[Component] = []: set = set_components
var _components_dict: Dictionary = {}
var _status_effects: Array[StatusEffectResource]

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	pass

# builtin #---------------------------------------------------------------------
func _process(delta: float) -> void:
	for status_effect in _status_effects:
		status_effect.on_update(delta, self)

# method #----------------------------------------------------------------------
static func find_status_effect_component(node: Node) -> StatusEffectComponent:
	return U.find_of_type(node, StatusEffectComponent)[0]

# method #----------------------------------------------------------------------
func set_components(value: Array[Component]) -> void:
	components = value
	for component in value:
		var script_key: Variant = component.get_script()
		if !_components_dict.has(script_key): _components_dict.set(script_key, component)
		else: push_warning(self, "%s component alredy assigned" % script_key)

# method #----------------------------------------------------------------------
func get_component(type: Variant) -> Component:
	return _components_dict.get(type, null)

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


# method #----------------------------------------------------------------------
func get_status_effects(type: Variant) -> Array[StatusEffectResource]:
	return _status_effects.filter(
		func(effect: StatusEffectResource) -> bool:
			return is_instance_of(effect, type)
	)

# callback #--------------------------------------------------------------------
