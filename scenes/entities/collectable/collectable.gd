class_name Collectable extends Area2D
# variables #-------------------------------------------------------------------
@export var status_effects: Array[StatusEffectResource] = []
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	if not animated_sprite_2d: return push_error("AnimatedSprite2D is not defined")
	if not collision_shape_2d: return push_error("CollisionShape2D is not defined")
	body_entered.connect(_on_body_entered)
	animated_sprite_2d.play("idle")

# method #----------------------------------------------------------------------
func die() -> void:
	Util.log("Collectable died")
	collision_shape_2d.disabled = true
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()

# method #----------------------------------------------------------------------
func get_effects() -> Array[StatusEffectResource]:
	return status_effects

# TODO: think about base class/scene for entities to access "status_effect_component" safely
# callback #--------------------------------------------------------------------
func _on_body_entered(who: Node2D) -> void:
	print("Collected!")
	if not who.is_in_group(Global.GROUP_NAME_PLAYER): return
	if not who.get("status_effect_component") is StatusEffectComponent: return
	for effect: StatusEffectResource in status_effects:
		who.status_effect_component.apply_status_effect(effect)
	die.call_deferred()
