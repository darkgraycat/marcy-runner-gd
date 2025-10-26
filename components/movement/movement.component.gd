class_name MovementComponent extends Component

# variables #-------------------------------------------------------------------
@export var direction: float = 0.0
@export var target_speed: float = 50.0
@export var acceleration: float = 10.0

# builtin #---------------------------------------------------------------------
func _physics_process(delta: float) -> void:
	handle_movement(direction, delta)

# method #----------------------------------------------------------------------
func handle_movement(new_direction: float, delta: float) -> void:
	parent.velocity.x = lerp(
		parent.velocity.x,
		new_direction * target_speed,
		1.0 - exp(-acceleration * delta)
	)
	parent.move_and_slide()

# method #----------------------------------------------------------------------
func set_direction(new_direction: float) -> void:
	direction = new_direction
