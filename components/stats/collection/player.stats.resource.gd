class_name PlayerStatsResource extends StatsResource

const Key = {
	Health = "Health",
	Invincible = "Invincible",
	Acceleration = "Acceleration",
	MoveVelocity = "MoveVelocity",
	JumpVelocity = "JumpVelocity",
}

@export var attributes: Dictionary[String, float] = {
	Key.Health: 9.0,
	Key.Acceleration: 5.0,
	Key.MoveVelocity: 100.0,
	Key.JumpVelocity: 250.0,
	Key.Invincible: 1
}

func get_attributes() -> Dictionary[String, float]: return attributes
