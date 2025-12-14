class_name AttributesEffect extends Resource

enum Operation {Set, Add, Multiply}

@export var name: StringName
@export var key: Attributes.Key
@export var value := 0.0
@export var operation := Operation.Set
@export var duration := 0.0

func apply(attributes: Attributes) -> void:
	var final_value: float
	
	match operation:
		Operation.Set: final_value = value
		Operation.Add: final_value = attributes.getv(key) + value
		Operation.Multiply: final_value = attributes.getv(key) * value
	
	if duration > 0.0:
		attributes.setv_timed(key, final_value, duration)
	else:
		attributes.setv(key, final_value)
