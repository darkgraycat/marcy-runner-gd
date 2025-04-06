class_name Block extends Node2D

const TILE_WIDTH = 48
const TILE_HEIGHT = 32

@onready var head: Sprite2D = $BlockHead
@onready var decor: Sprite2D = $BlockDecor
@onready var segments: Array[Sprite2D] = [
	$BlockSegment0,
	$BlockSegment1,
	$BlockSegment2,
	$BlockSegment3,
	$BlockSegment4,
]

func _ready() -> void:
	randomize()

func randomize() -> void:
	head.frame = randi_range(0, 4)
	decor.frame = randi_range(0, 4)
	for segment in segments:
		segment.frame = randi_range(0, 6)

func is_offscreen(scroll_x: float) -> bool:
	return global_position.x + TILE_WIDTH >= scroll_x
