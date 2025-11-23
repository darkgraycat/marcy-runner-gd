class_name Enemy extends CharacterBody2D

@export var movement_direction := 0.0

@export var collision_shape_2d: CollisionShape2D
@export var sprite_2d: Sprite2D
@export var animation_player: AnimationPlayer
@export var hurbox_area_2d: Area2D
@export var status_effects: Array[StatusEffectResource] = []

@onready var c_velocity: CVelocity = $Components/CVelocity

var is_dying: bool = false

func _ready() -> void:
	if !sprite_2d: return push_error(self, "Sprite2D is not defined")
	if !animation_player: return push_error(self, "AnimationPlayer is not defined")
	if !hurbox_area_2d: return push_error(self, "HurtBoxArea2D is not defined")
	hurbox_area_2d.body_entered.connect(_on_hurbox_area_2d_body_entered)
	animation_player.play("idle")

	if c_velocity: c_velocity.move(movement_direction)


func _physics_process(_delta: float) -> void:
	move_and_slide()


func die() -> void:
	set_physics_process(false)
	collision_shape_2d.disabled = true
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()


func damage(body: CharacterBody2D) -> void:
	if is_dying: return
	is_dying = true
	if !body.is_in_group(Globals.GROUP_NAME_PLAYER): return

	var sec := StatusEffectComponent.find_status_effect_component(body)
	if !sec:
		die.call_deferred() # effect target is not found - do nothing
		return

	var health_component: HealthComponent = sec.get_component(HealthComponent)
	if health_component && health_component.is_invincible():
		die.call_deferred() # invincible
		return

	sec.apply_status_effects(status_effects)
	die.call_deferred()


func _on_hurbox_area_2d_body_entered(body: Node2D) -> void:
	damage(body)
