class_name StatsComponent extends Component

signal changed(key: String, value: float)

@export var stats: StatsResource

func _ready() -> void:
	assert(stats, "StatsResource is not defined")
	stats._init()

func getv(key: String) -> float:
	return stats._attrs[key]

func setv(key: String, value: float) -> float:
	stats._attrs[key] = value
	changed.emit(key, value)
	return value

func modv(key: String, value: float) -> float:
	stats._attrs[key] += value
	changed.emit(key, stats._attrs[key])
	return stats._attrs[key]

func enabled(key: String) -> bool:
	return stats._attrs[key] > 0.0

func switch(key: String, flag: bool) -> void:
	stats._attrs[key] = 1.0 if flag else 0.0
	changed.emit(key, stats._attrs[key])
