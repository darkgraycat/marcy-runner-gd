class_name MovementComponent extends Component

# variables #-------------------------------------------------------------------
@export var direction: Vector2 = Vector2.ZERO
@export var max_velocity: Vector2 = Vector2.ZERO
@export var acceleration: Vector2 = Vector2.ZERO
@export var gravity: Vector2 = Vector2.ZERO

# builtin #---------------------------------------------------------------------
func _physics_process(delta: float) -> void:
	var target_velocity := direction * max_velocity
	var fx := 1.0 - exp(-acceleration.x * delta)
	var fy := 1.0 - exp(-acceleration.y * delta)

	parent.velocity.x = lerp(parent.velocity.x, target_velocity.x, fx)
	parent.velocity.y = lerp(parent.velocity.y, target_velocity.y, fy)
	parent.velocity += gravity * delta
	parent.move_and_slide()

# method #----------------------------------------------------------------------
static func get_from(
	from: Node,
	property: String = "movement_component"
) -> MovementComponent:
	return Component.get_component(from, property, MovementComponent)

# callback #--------------------------------------------------------------------
