class_name StatusEffectComponent extends Component
signal status_effect_applied(status_effect: StatusEffectResource)
signal status_effect_destroyed(status_effect: StatusEffectResource)


@export var components: Array[Component] = []: set = set_components
var _components: Dictionary[Object, Component] = {}
var _status_effects: Array[StatusEffectResource]


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	for status_effect in _status_effects:
		status_effect.on_update(delta, self)


static func find_status_effect_component(node: Node) -> StatusEffectComponent:
	return Utils.find_nodes_of_type(node, StatusEffectComponent)[0]


func set_components(value: Array[Component]) -> void:
	components = value
	for component in value:
		var script_key: Variant = component.get_script()
		if !_components.has(script_key):
			_components.set(script_key, component)
			Utils.log("Component added %s" % component)
		else:
			push_warning(self, "%s component already assigned" % script_key)


func get_component(type: Variant) -> Component:
	return _components.get(type, null)


func apply_status_effect(status_effect: StatusEffectResource) -> void:
	_status_effects.append(status_effect)
	status_effect.on_apply(self)
	status_effect_applied.emit(status_effect)


func apply_status_effects(status_effects: Array[StatusEffectResource]) -> void:
	for effect: StatusEffectResource in status_effects:
		apply_status_effect(effect)


func destroy_status_effect(status_effect: StatusEffectResource) -> void:
	_status_effects.erase(status_effect)
	status_effect.on_destroy(self)
	status_effect_destroyed.emit(status_effect)


func destroy_all_status_effects() -> void:
	for status_effect: StatusEffectResource in _status_effects:
		_status_effects.erase(status_effect)
		status_effect.on_destroy(self)
		status_effect_destroyed.emit(status_effect)


func get_status_effects(type: Script) -> Array[StatusEffectResource]:
	return _status_effects.filter(
		func(effect: StatusEffectResource) -> bool:
			return effect.get_script() == type
	)
