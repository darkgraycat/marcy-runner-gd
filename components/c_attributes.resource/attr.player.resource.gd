class_name AttrPlayer extends AttributesResource

const Key = {
	Health = "Health",
	Acceleration = "Acceleration",
	MoveVelocity = "MoveVelocity",
	JumpVelocity = "JumpVelocity",
	JumpsAmount = "JumpsAmount",
	Invincible = "Invincible",
	BodyWeight = "BodyWeight",
}

@export var attributes: Dictionary[String, float] = {
	Key.Health: 9,
	Key.Acceleration: 5.0,
	Key.MoveVelocity: 100,
	Key.JumpVelocity: 250,
	Key.JumpsAmount: 1,
	Key.Invincible: 0,
	Key.BodyWeight: 1.25,
}

func get_attributes() -> Dictionary[String, float]: return attributes
