class_name Block extends Node2D

const TILE_WIDTH = 48
const TILE_HEIGHT = 32

@onready var head: Sprite2D = $Sprite2DHead
@onready var decor: Sprite2D = $Sprite2DDecor
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
	head.frame = randi_range(0, 3)
	decor.frame = randi_range(0, 2)
	var segment_frame := randi_range(0, 5)
	for segment in segments:
		segment.frame = segment_frame

func is_offscreen(camera_2d: Camera2D) -> bool:
	var scroll_x := camera_2d.global_position.x - Global.VIEWPORT_WIDTH / 2.0
	var right_x := global_position.x + TILE_WIDTH
	return right_x >= scroll_x
