class_name CAttributes extends Node

signal changed(key: String, value: float)
signal switched(key: String, value: bool)

@export var data: CAttributesResource


func _ready() -> void:
	assert(data, "CAttributesResource is not defined")
	data._init()


func getv(key: String) -> float:
	return data._attrs[key]


func setv(key: String, value: float) -> void:
	data._attrs[key] = value
	changed.emit(key, value)


func modv(key: String, value: float) -> float:
	setv(key, value)
	return data._attrs[key]


func geti(key: String) -> int:
	return int(data._attrs[key])


func seti(key: String, value: int) -> void:
	data._attrs[key] = float(value)
	changed.emit(key, value)


func modi(key: String, value: int) -> int:
	seti(key, value)
	return int(data._attrs[key])



func enabled(key: String) -> bool:
	return data._attrs[key] > 0.0


func switch(key: String, flag: bool) -> void:
	data._attrs[key] = 1.0 if flag else 0.0
	switched.emit(key, flag)
