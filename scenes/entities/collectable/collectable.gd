class_name Collectable extends Area2D
signal item_collected(item: Collectable)

# variables #-------------------------------------------------------------------
@export var status_effects: Array[StatusEffectResource] = []
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	if !animated_sprite_2d: return push_error(self, "AnimatedSprite2D is not defined")
	if !collision_shape_2d: return push_error(self, "CollisionShape2D is not defined")
	body_entered.connect(_on_body_entered)
	animated_sprite_2d.play("idle")

# method #----------------------------------------------------------------------
func die() -> void:
	U.log("Collectable died")
	collision_shape_2d.disabled = true
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()

# method #----------------------------------------------------------------------
func get_effects() -> Array[StatusEffectResource]:
	return status_effects

# method #----------------------------------------------------------------------
func collect(target: Node2D) -> void:
	if !target.is_in_group(G.GROUP_NAME_PLAYER): return
	var sec := StatusEffectComponent.find_status_effect_component(target)
	if !sec: return # effect target is not found - do nothing
	sec.apply_status_effects(status_effects)
	item_collected.emit(self)
	die.call_deferred()

# callback #--------------------------------------------------------------------
func _on_body_entered(body: Node2D) -> void:
	collect(body)
