class_name AttrPlayer extends CAttributesResource

const Key = {
	Health = "Health",
	Invincible = "Invincible",
	Acceleration = "Acceleration",
	MoveVelocity = "MoveVelocity",
	JumpVelocity = "JumpVelocity",
	JumpsAmount = "JumpsAmount"
}

@export var attributes: Dictionary[String, float] = {
	Key.Health: 9.0,
	Key.Acceleration: 5.0,
	Key.MoveVelocity: 100.0,
	Key.JumpVelocity: 250.0,
	Key.JumpsAmount: 1,
	Key.Invincible: 1
}

func get_attributes() -> Dictionary[String, float]: return attributes
