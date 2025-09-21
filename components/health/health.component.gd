class_name HealthComponent extends Component
signal died()
signal health_changed(health: float)

# variables #-------------------------------------------------------------------
@export var max_health: float = 10
@export var damage_interval_sec: float = 1
var health: float: set = set_current_health
var _last_damaged_msec: float = 0

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	health = max_health

# method #----------------------------------------------------------------------
func set_current_health(value: float) -> void:
	health = value
	health_changed.emit(health)
	if health <= 0:
		died.emit()

# method #----------------------------------------------------------------------
func damage(amount: float) -> void:
	if is_on_damage_cooldown(): return
	health = max(health - amount, 0)
	_last_damaged_msec = Time.get_unix_time_from_system()
	Util.log("Damage - restart")

# method #----------------------------------------------------------------------
func heal(amount: float) -> void:
	Util.log("Healing", amount)
	health = min(health + amount, max_health)

# method #----------------------------------------------------------------------
func is_on_damage_cooldown() -> bool:
	return _last_damaged_msec + damage_interval_sec > Time.get_unix_time_from_system()

# callback #--------------------------------------------------------------------
