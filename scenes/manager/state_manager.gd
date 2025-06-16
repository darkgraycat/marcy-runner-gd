class_name StateManager extends Node

signal state_updated(state: Dictionary)

var state: Dictionary = {
	score = 0,
	lifes = 0,
	bonus_speed = 0.0,
}

func _ready() -> void:
	Events.item_collected.connect(_on_item_collected)


func get_value(key: String) -> Variant:
	return state[key]


func set_value(key: String, value: Variant) -> void:
	state[key] = value
	state_updated.emit(state)


func _on_item_collected(item: Item) -> void:
	var effect_amount := item.get_effect_amount()
	match item.get_effect():
		ItemConfig.ItemEffect.None: pass
		ItemConfig.ItemEffect.Score: set_value("score", state.score + int(effect_amount))
		ItemConfig.ItemEffect.BonusSpeed: set_value("bonus_speed", state.bonus_speed + effect_amount)
		ItemConfig.ItemEffect.AdditionalLife: set_value("lifes", state.lifes + int(effect_amount))
		_: push_warning("unknown item effect %s" % item.get_effect())
