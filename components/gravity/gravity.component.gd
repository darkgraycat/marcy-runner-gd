class_name GravityComponent extends Component

# variables #-------------------------------------------------------------------
@export var weight: float = 1.0: set = set_weight
var is_falling: bool = false
var _force: float = 0.0

# builtin #---------------------------------------------------------------------
func _physics_process(delta: float) -> void:
	handle_gravity(parent, delta)

# method #----------------------------------------------------------------------
func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if !body.is_on_floor():
		body.velocity.y += _force * delta
	is_falling = body.velocity.y > 0 && !body.is_on_floor()

# method #----------------------------------------------------------------------
func set_weight(value: float) -> void:
	weight = value
	_force = value * Globals.GRAVITY

# callback #--------------------------------------------------------------------
