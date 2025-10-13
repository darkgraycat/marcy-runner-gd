class_name BonusSpeedComponent extends Component

# variables #-------------------------------------------------------------------
@export var movement_component: MovementComponent
@export var max_bonus_speed: float = 1000.0

var bonus_speed: float = 0.0: set = set_bonus_speed
var parent_target_speed: float = 0.0

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	await parent.ready
	parent_target_speed = movement_component.target_speed
	U.log("PARENT TS", parent_target_speed)

# method #----------------------------------------------------------------------
func set_bonus_speed(new_bonus_speed: float) -> void:
	bonus_speed = min(new_bonus_speed, max_bonus_speed)
	movement_component.target_speed = parent_target_speed + bonus_speed
	U.log("SET BS %s, TS %s" % [bonus_speed, movement_component.target_speed])

# callback #--------------------------------------------------------------------
