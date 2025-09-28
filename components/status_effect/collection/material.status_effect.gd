class_name MaterialStatusEffect extends StatusEffectResource

# variables #-------------------------------------------------------------------
@export var duration_sec: float = 10
@export var material: Material

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	pass

# method #----------------------------------------------------------------------
func on_apply(status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func on_destroy(status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func on_update(delta: float, status_effect_component: StatusEffectComponent) -> void:
	pass

# method #----------------------------------------------------------------------
func _find_visuals(body: CharacterBody2D) -> void:
	for node in body.get_children():
		if node is Sprite2D:
			pass

# callback #--------------------------------------------------------------------
