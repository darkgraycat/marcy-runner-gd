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
	ScorePoints,
}

@export var body: CharacterBody2D
@export var values: Dictionary[Attributes.Key, float]

func _ready() -> void:
	assert(body, "CharacterBody2D is not defined")
	assert(values, "AttributesResource is not defined")
	body.add_to_group(GROUP_NAME)

static func get_attributes(node: Node) -> Attributes:
	if not "attributes" in node || not node.attributes is Attributes:
		return null
	return node.attributes

func has(key: int) -> bool:
	return values.has(key)

func getv(key: int) -> float:
	return values.get(key, 0.0)

func setv(key: int, value: float) -> void:
	values.set(key, value)
	changed.emit(key, value)

func enabled(key: int) -> bool:
	return getv(key) > 0

func switch(key: int, value: bool) -> void:
	setv(key, 1 if value else 0)
	switched.emit(key, value)

func setv_timed(key: int, value: float, seconds: float) -> void:
	var diff := getv(key) - value
	setv(key, value)
	await Utils.sleep(seconds)
	var v := getv(key) + diff
	setv(key, v)
	expired.emit()

func switch_timed(key: int, value: bool, seconds: float) -> void:
	await setv_timed(key, 1 if value else 0, seconds)
