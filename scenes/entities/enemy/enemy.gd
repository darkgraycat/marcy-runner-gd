class_name Enemy extends CharacterBody2D

@export var collision_shape_2d: CollisionShape2D
@export var sprite_2d: Sprite2D
@export var animation_player: AnimationPlayer
@export var hurbox_area_2d: Area2D
@export var effects: Array[EffectResource] = []

func _ready() -> void:
	if not sprite_2d: return push_error("Sprite2D is not defined")
	if not animation_player: return push_error("AnimationPlayer is not defined")
	if not hurbox_area_2d: return push_error("HurtBoxArea2D is not defined")
	hurbox_area_2d.body_entered.connect(damage)
	animation_player.play("idle")


func die() -> void:
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()


func damage(who: Node2D) -> void:
	if not who.is_in_group(Global.GROUP_NAME_PLAYER): return
	if not who.effect_reciever is EffectReciever: return
	for effect: EffectResource in effects:
		who.effect_reciever.apply_effect(effect)
	prints(self, "DAMAGE", who)
	die.call_deferred()
