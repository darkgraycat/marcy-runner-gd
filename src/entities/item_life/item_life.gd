class_name ItemLife extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_area: PickupArea = $PickupArea

func _ready() -> void:
	pickup_area.picked.connect(func (_node: Node2D) -> void:
		Events.emit_player_item_collected(self)
		die.call_deferred()
	)

func die() -> void:
	animated_sprite_2d.play("die")
	await animated_sprite_2d.animation_finished
	queue_free()
