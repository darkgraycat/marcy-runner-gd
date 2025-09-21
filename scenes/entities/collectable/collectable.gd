class_name Collectable extends Area2D

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
	Util.log("Collectable died")
	collision_shape_2d.disabled = true
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()

# method #----------------------------------------------------------------------
func get_effects() -> Array[StatusEffectResource]:
	return status_effects

# callback #--------------------------------------------------------------------
func _on_body_entered(who: Node2D) -> void:
	if not who.is_in_group(Global.GROUP_NAME_PLAYER): return
	var sec := StatusEffectComponent.get_from(who)
	if !sec: return
	for effect: StatusEffectResource in status_effects:
		sec.apply_status_effect(effect)
	die.call_deferred()
