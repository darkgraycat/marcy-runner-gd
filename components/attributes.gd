class_name Attributes extends Node

signal changed(key: int, value: float)
signal switched(key: int, value: bool)
signal expired(key: int)

const GROUP_NAME = "withAttributes"

enum Key {
	Health,
	MaxHealth,
	MoveAccel,
	MoveSpeed,
	JumpForce,
	JumpAmount,
	Invincible,
	BodyWeight,
}

@export var body: CharacterBody2D
@export var values: Dictionary[Attributes.Key, float]

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
	assert(values, "AttributesResource is not defined")
	body.add_to_group(GROUP_NAME)

static func get_attributes(node: Node) -> Attributes:
	if !"attributes" in node || !node.attributes is Attributes:
		return null
	return node.attributes

func has(key: int) -> bool:
	return values.has(key)

func getv(key: int) -> float:
	return values[key]

func setv(key: int, value: float) -> void:
	values[key] = value
	print("Changed")
	changed.emit(key, value)

func geti(key: int) -> int:
	return int(getv(key))

func seti(key: int, value: int) -> void:
	return setv(key, float(value))

func enabled(key: int) -> bool:
	return getv(key) > 0

func switch(key: int, value: bool) -> void:
	setv(key, 1 if value else 0)
	switched.emit(key, value)

func setv_timed(key: int, value: float, seconds: float) -> void:
	var prev := getv(key)
	setv(key, value)
	await Utils.sleep(seconds)
	setv(key, prev)
	expired.emit()

func seti_timed(key: int, value: int, seconds: float) -> void:
	await setv_timed(key, float(value), seconds)

func switch_timed(key: int, value: bool, seconds: float) -> void:
	await setv_timed(key, 1 if value else 0, seconds)
