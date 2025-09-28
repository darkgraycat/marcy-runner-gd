class_name HealthComponent extends Component
signal died()
signal health_changed(health: float, prev_health: float)

# variables #-------------------------------------------------------------------
@export var max_health: float = 10
@export var damage_interval_sec: float = 1
var health: float: set = set_health
var _last_hit_timestamp: float = 0
var _original_modulate: Color = Color.WHITE

# builtin #---------------------------------------------------------------------
func _ready() -> void:
	health = max_health
	_last_hit_timestamp = U.time
	_original_modulate = parent.modulate

func _process(delta: float) -> void:
	E.emit_debug_message("INV_TIME: %s" % ceil(get_invincibility_time_sec()), 999)

# method #----------------------------------------------------------------------
func set_health(value: float) -> void:
	health = value
	health_changed.emit(health)
	if health <= 0:
		died.emit()

# method #----------------------------------------------------------------------
func damage(amount: float) -> void:
	if is_invincible() && amount > 0: return
	health = max(health - amount, 0)
	_last_hit_timestamp = U.time
	var inv_left := get_invincibility_time_sec()
	var tween := parent.create_tween()
	tween.set_loops(int(inv_left * 3))
	tween.tween_property(parent, ^"modulate", Color(1, 1, 1, 0.1), 0.2)
	tween.tween_property(parent, ^"modulate", _original_modulate, 0.2)

# method #----------------------------------------------------------------------
func heal(amount: float) -> void:
	health = min(health + amount, max_health)

# method #----------------------------------------------------------------------
func is_invincible() -> bool:
	return _last_hit_timestamp + damage_interval_sec > U.time

# method #----------------------------------------------------------------------
func set_invincibility_time_sec(seconds: float) -> void:
	_last_hit_timestamp = U.time + seconds

# method #----------------------------------------------------------------------
func get_invincibility_time_sec() -> float:
	return max(0, _last_hit_timestamp + damage_interval_sec - U.time)

# callback #--------------------------------------------------------------------
