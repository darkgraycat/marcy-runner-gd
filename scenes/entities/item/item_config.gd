class_name ItemConfig extends Resource

enum ItemType { Panacat, Bean, Life }
enum ItemEffect { None, Score, BonusSpeed, AdditionalLife }

@export var type: ItemType = ItemType.Panacat
@export var effect: ItemEffect = ItemEffect.None
@export var effect_amount: float = 0.0
