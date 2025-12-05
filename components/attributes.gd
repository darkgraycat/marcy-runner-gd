class_name Attributes extends Node

signal changed(key: String, value: float)
signal switched(key: String, value: bool)

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
	setv(key, attributes.values[key] + value)

func geti(key: String) -> int:
	return int(attributes.values[key])

func seti(key: String, value: int) -> void:
	attributes.values[key] = float(value)
	changed.emit(key, value)

func addi(key: String, value: int) -> void:
	seti(key, int(attributes.values[key] + value))

func enabled(key: String) -> bool:
	return getv(key) > 0

func switch(key: String, value: bool) -> void:
	attributes.values[key] = 1 if value else 0
	switched.emit(key, value)
