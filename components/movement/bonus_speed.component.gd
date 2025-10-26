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
	Utils.log("PARENT TS", parent_target_speed)

# method #----------------------------------------------------------------------
func set_bonus_speed(new_bonus_speed: float) -> void:
	bonus_speed = min(new_bonus_speed, max_bonus_speed)
	movement_component.target_speed = parent_target_speed + bonus_speed
	Utils.log("SET BS %s, TS %s" % [bonus_speed, movement_component.target_speed])

# callback #--------------------------------------------------------------------

# NOTE: Bug # ------------------------------------------------------------------
# collect many beans in very short period
# then collect anything with dispel effect
# Reason:
# bonus speed cap = 150. dispel calls on_destroy and it substracts, but substracts from 150
# and we cant limit to decrease to 0, because of slow effects
