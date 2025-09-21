class_name HealthComponent extends Component
signal died()
signal health_changed(health: float)

# variables #-------------------------------------------------------------------
@export var max_health: float = 10
@export var damage_interval: float = 1
var current_health: float
var _damage_timer: SceneTreeTimer

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	current_health = max_health
	_damage_timer = get_tree().create_timer(damage_interval)

# method #----------------------------------------------------------------------
func damage(amount: float) -> void:
	if _damage_timer.time_left > 0:
		Util.log("No damage - cooldown")
		return
	current_health = max(current_health - amount, 0)
	health_changed.emit()
	Util.log("Damage - restart")
	_damage_timer.time_left = damage_interval
	if current_health <= 0:
		died.emit()

# method #----------------------------------------------------------------------
func heal(amount: float) -> void:
	current_health = min(current_health + amount, max_health)


# callback #--------------------------------------------------------------------
