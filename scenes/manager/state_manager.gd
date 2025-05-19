class_name StateManager extends Node

var score: int = 0
var lifes: int = 3
var speed_bonus: float = 0.0


func _ready() -> void:
	Events.item_collected.connect(_on_item_collected)


func _on_item_collected(item: Item) -> void:
	prints("item", item)
	# prints("item collected %s" % item.get_type())
	match item.get_effect():
		ItemConfig.ItemEffect.None: pass
		ItemConfig.ItemEffect.Score: score += int(item.get_effect_amount())
		ItemConfig.ItemEffect.BonusSpeed: speed_bonus += item.get_effect_amount()
		ItemConfig.ItemEffect.AdditionalLife: lifes += int(item.get_effect_amount())
		_: push_warning("unknown item effect %s" % item.get_effect())
