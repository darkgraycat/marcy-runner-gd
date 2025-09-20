class_name Item extends Area2D

@export var animated_sprite_2d: AnimatedSprite2D
@export var collision_shape_2d: CollisionShape2D
@export var effects: Array[EffectResource] = []


func _ready() -> void:
	if not animated_sprite_2d: return push_error("AnimatedSprite2D is not defined")
	if not collision_shape_2d: return push_error("CollisionShape2D is not defined")
	body_entered.connect(collect)
	animated_sprite_2d.play("idle")


func collect(who: Node2D) -> void:
	if not who.is_in_group(Global.GROUP_NAME_PLAYER): return
	if not who.get("effect_reciever") is EffectReciever: return
	# if not ("effect_reciever" in who and who.effect_reciever is EffectReciever): return
	#if not who.effect_reciever is EffectReciever: return
	for effect: EffectResource in effects:
		who.effect_reciever.apply_effect(effect)

	#who.effect_reciever.apply_effect(effect)
	die.call_deferred()


func die() -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()


func get_effects() -> Array[EffectResource]:
	return effects
