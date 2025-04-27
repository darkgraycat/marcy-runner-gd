class_name BlockGenerator extends Node2D

@export var blocks_root: Node2D
@export var minimums: Vector2i
@export var maximums: Vector2i
@export var increment: int = 1
@export var decrement: int = 1

var _blocks: Array[Block] = []
var _prev_width: int = 0
var _prev_height: int = 0

func _ready() -> void:
	blocks_root.get_children().map(_blocks.append)

	for block: Block in blocks_root.get_children():
		block.activated.connect(_on_block_activated)
		block.deactivated.connect(_on_block_deactivated)

func _calculate_next_height() -> int:
	var limit_width: int = randi_range(minimums.x, maximums.x)
	if _prev_width <= limit_width:
		_prev_width += 1
		_prev_height = randi_range(
			maxi(_prev_height - decrement, minimums.y),
			maxi(_prev_height + increment, maximums.y),
		)
	else:
		_prev_width = -1
		_prev_height = -1
	return _prev_height

func _on_block_activated(block: Block) -> void:
	prints("Block activated",block)

func _on_block_deactivated(block: Block) -> void:
	prints("Block deactivated",block)
