class_name Block extends Node2D

@onready var block_head: Sprite2D = $BlockHead
@onready var block_decor: Sprite2D = $BlockDecor
@onready var block_segments: Array[Sprite2D] = [
	$BlockSegment0,
	$BlockSegment1,
	$BlockSegment2,
	$BlockSegment3,
]

func _ready() -> void:
	randomize()

func randomize() -> void:
	block_head.frame = randi_range(0, 4)
	block_decor.frame = randi_range(0, 4)
	for segment in block_segments:
		segment.frame = randi_range(0, 6)
