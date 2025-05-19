@tool
class_name Item extends Area2D

@export var config: ItemConfig = ItemConfig.new(): set = set_config

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func _ready() -> void:
	animated_sprite_2d.play("panacat_idle")
	pass


func set_config(new_config: ItemConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready

	animated_sprite_2d.play(get_animation_prefix() + "_idle")


func collect(who: Node2D) -> void:
	if not who.is_in_group(Global.GROUP_NAME_PLAYER):
		return
	Events.emit_item_collected(self)
	call_deferred("die")


func die() -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.play(get_animation_prefix() + "_die")
	await animated_sprite_2d.animation_finished
	queue_free()


func get_animation_prefix() -> String:
	match get_type():
		ItemConfig.ItemType.Panacat: return 'panacat'
		ItemConfig.ItemType.Bean: return 'bean'
		ItemConfig.ItemType.Life: return 'life'
		_: return 'panacat'


func get_type() -> ItemConfig.ItemType:
	return config.type


func get_effect() -> ItemConfig.ItemEffect:
	return config.effect


func get_effect_amount() -> float:
	return config.effect_amount
