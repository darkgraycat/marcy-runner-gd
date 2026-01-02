extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	animation_player.play("idle")
	$Area2D.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(_delta: float) -> void:
	pass
	#move_and_slide()

func die() -> void:
	set_physics_process(false)
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free.call_deferred()

# TODO: move into Hurtbox component
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group(Global.GROUP_NAME_PLAYER):
		body.velocity = Vector2(0, -600) # knockback
		Events.emit_player_hit()
		die.call_deferred()
