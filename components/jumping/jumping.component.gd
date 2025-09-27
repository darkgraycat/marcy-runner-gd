class_name JumpingComponent extends Component

# variables #-------------------------------------------------------------------
@export var jump_input: bool = false
@export var jump_force: float = 300.0
@export var jump_count: int = 1

var is_jumping: bool = false
var jumped_times: int = 0

# builtin #---------------------------------------------------------------------
func _physics_process(delta: float) -> void:
	handle_jumping(parent, delta)

# method #----------------------------------------------------------------------
func handle_jumping(body: CharacterBody2D, _delta: float) -> void:
	if jump_input && body.is_on_floor():
		body.velocity.y = -jump_force

	is_jumping = body.velocity.y < 0 && !body.is_on_floor()

# callback #--------------------------------------------------------------------

