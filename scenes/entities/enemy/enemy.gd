@tool
class_name Enemy extends CharacterBody2D

@export var config: EnemyConfig = EnemyConfig.new(): set = set_config

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func set_config(new_config: EnemyConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready

	animated_sprite_2d.play(get_animation_prefix() + "_idle")


func die() -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.play(get_animation_prefix() + "_die")
	await animated_sprite_2d.animation_finished
	queue_free()


func get_animation_prefix() -> String:
	match get_type():
		EnemyConfig.EnemyType.Drone: return 'drone'
		EnemyConfig.EnemyType.Station: return 'station'
		_: return 'drone'


func get_type() -> EnemyConfig.EnemyType:
	return config.type
