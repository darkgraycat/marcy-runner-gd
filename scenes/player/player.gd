class_name Player extends CharacterBody2D

@export var move_velocity: float = Global.DEFAULT_MOVE_VELOCITY
@export var jump_velocity: float = Global.DEFAULT_JUMP_VELOCITY

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var input_move: float = 0.0
var input_jump: bool = false
var is_jumping: bool = false

func _physics_process(delta: float) -> void:
	if input_move:
		animated_sprite_2d.scale.x = input_move
		velocity.x = input_move * move_velocity
	else:
		velocity.x = move_toward(velocity.x, 0, move_velocity)

	if input_jump and !is_jumping and is_on_floor():
		is_jumping = true
		velocity.y = -jump_velocity

	if !input_jump:
		is_jumping = false
		if velocity.y < 0:
			velocity.y = velocity.y / 2

	if !is_on_floor():
		velocity.y += Global.GRAVITY * delta

	animated_sprite_2d.play(get_current_state())
	move_and_slide()

func get_current_state() -> StringName:
	return (
		"jump" if not is_on_floor() else
		"walk" if input_move else "idle"
	)


# if (this.isJumping && !this.isJumpInProgress) { // jump button is just pressed
#     if (this.player.isLanded)
#         this.isJumpInProgress = true;
#     this.player.jump(jumpVelocity);
#        if (this.isLanded) {
#            this.body.velocity.y = -velocity;
#            this.anims.play(AnimationKey.PlayerJump, true)
#            this.soundJump.play({ detune: -400 });
#        }
# }
#
# if (!this.isJumping) { // jump button released
#     this.isJumpInProgress = false;
#     if (this.player.body.velocity.y < 0)
#         this.player.body.velocity.y /= 2;
#     if (this.player.isLanded)
#         this.isJumpInProgress = false;
# }

# Stolen code. TODO: check
#	if is_on_floor():
#		onGround = true
#		if Input.is_action_pressed("ui_up"):
#			velocity.y = JUMP_POWER
#	else:
#		onGround = false
#		velocity.y += GRAVITY
#		if velocity.y < 0:
#			$AnimatedSprite.play("Jump")
#		else:
#			$AnimatedSprite.play("Fall")
