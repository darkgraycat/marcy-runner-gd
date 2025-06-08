class_name Item extends Area2D

@export var config: ItemConfig = ItemConfig.new(): set = set_config
@export var animated_sprite_2d: AnimatedSprite2D
@export var collision_shape_2d: CollisionShape2D

func _ready() -> void:
	if not animated_sprite_2d: return push_error("AnimatedSprite2D is not defined")
	if not collision_shape_2d: return push_error("CollisionShape2D is not defined")
	body_entered.connect(collect)


func set_config(new_config: ItemConfig) -> void:
	config = new_config
	if animated_sprite_2d:
		animated_sprite_2d.play("idle")


func collect(who: Node2D) -> void:
	if not who.is_in_group(Global.GROUP_NAME_PLAYER):
		return
	Events.emit_item_collected(self)
	call_deferred("die")


func die() -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()


func get_type() -> ItemConfig.ItemType:
	return config.type


func get_effect() -> ItemConfig.ItemEffect:
	return config.effect


func get_effect_amount() -> float:
	return config.effect_amount
