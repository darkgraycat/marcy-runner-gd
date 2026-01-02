class_name Hurtbox extends Area2D

@export var body: CharacterBody2D
@export var health: Health

func _ready() -> void:
	assert(body, "body is not defined")
	assert(health, "health is not defined")
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if not area is Hitbox:return
	var hitbox := area as Hitbox
	health.damage(hitbox.damage)
	body.velocity = hitbox.knockback
