# TODO: remove
extends Node

class BlockHeight:
	var min_cols: int
	var min_rows: int
	var max_cols: int
	var max_rows: int

	var increment: int
	var decrement: int

	var prev_cols: int = 0
	var prev_rows: int = 0

	func _init(
		range_cols: Array[int],
		range_rows: Array[int],
		differences: Array[int],
	) -> void:
		min_cols = range_cols[0]
		max_cols = range_cols[1]
		min_rows = range_rows[0]
		max_rows = range_rows[1]
		increment = differences[0]
		decrement = differences[1]

	func next() -> int:
		var limit_cols: int = randi_range(min_cols, max_cols)
		if prev_cols <= limit_cols:
			prev_cols += 1
			prev_rows = randi_range(
				maxi(prev_rows - decrement, min_rows),
				mini(prev_rows + increment, max_rows),
			)
		else:
			prev_cols = -1
			prev_rows = -1

		return prev_rows
