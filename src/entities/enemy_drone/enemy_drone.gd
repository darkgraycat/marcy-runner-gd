class_name EnemyDrone extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var movement: Movement = $Components/Movement
@onready var hitbox: Hitbox = $Hitbox

func _ready() -> void:
	animation_player.play("idle")
	hitbox.area_entered.connect(func (area: Area2D) -> void:
		if not area is Hurtbox: return
		die.call_deferred()
	)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	movement.move(-1) # move left from start

func die() -> void:
	set_physics_process(false)
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free.call_deferred()
