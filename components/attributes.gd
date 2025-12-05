class_name Attributes extends Node

signal changed(key: String, value: float)
signal switched(key: String, value: bool)
signal expired(key: String)

@export var attributes: AttributesResource

func _ready() -> void:
	assert(attributes, "AttributesResource is not defined")
	attributes._init()

func getv(key: String) -> float:
	return attributes.values[key]

func setv(key: String, value: float) -> void:
	attributes.values[key] = value
	changed.emit(key, value)

func addv(key: String, value: float) -> void:
	attributes.values[key] += value
	changed.emit(key, attributes.values[key])

func geti(key: String) -> int:
	return int(getv(key))

func seti(key: String, value: int) -> void:
	return setv(key, float(value))

func addi(key: String, value: int) -> void:
	return addv(key, float(value))

func enabled(key: String) -> bool:
	return getv(key) > 0

func switch(key: String, value: bool) -> void:
	setv(key, 1 if value else 0)
	switched.emit(key, value)

func setv_timed(key: String, value: float, seconds: float) -> void:
	var prev := getv(key)
	setv(key, value)
	await Utils.sleep(seconds)
	setv(key, prev)
	expired.emit()

func seti_timed(key: String, value: int, seconds: float) -> void:
	await setv_timed(key, float(value), seconds)

func switch_timed(key: String, value: bool, seconds: float) -> void:
	await setv_timed(key, 1 if value else 0, seconds)
