class_name Enemy extends CharacterBody2D

# variables #-------------------------------------------------------------------
@export var collision_shape_2d: CollisionShape2D
@export var sprite_2d: Sprite2D
@export var animation_player: AnimationPlayer
@export var hurbox_area_2d: Area2D
@export var status_effects: Array[StatusEffectResource] = []

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	if !sprite_2d: return push_error(self, "Sprite2D is not defined")
	if !animation_player: return push_error(self, "AnimationPlayer is not defined")
	if !hurbox_area_2d: return push_error(self, "HurtBoxArea2D is not defined")
	hurbox_area_2d.body_entered.connect(damage)
	animation_player.play("idle")

# method #----------------------------------------------------------------------
func die() -> void:
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()

# method #----------------------------------------------------------------------
func damage(who: Node2D) -> void:
	if not who.is_in_group(Global.GROUP_NAME_PLAYER): return
	if not who.get("effect_reciever") is EffectReciever: return
	# if not who.effect_reciever is EffectReciever: return
	for effect: StatusEffectResource in status_effects:
		who.effect_reciever.apply_effect(effect)
	prints(self, "DAMAGE", who)
	die.call_deferred()
