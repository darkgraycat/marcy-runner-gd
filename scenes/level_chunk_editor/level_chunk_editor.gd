@tool
class_name LevelChunkEditor extends Node2D

@export var saveBtn: bool = false: set = set_save
@export var loadBtn: bool = false: set = set_load
@export var data: LevelChunkData

@onready var root: Node2D = %Root

func set_save(_x: bool) -> void:
	saveBtn = false
	print("save pressed")

func set_load(_x: bool) -> void:
	loadBtn = false
	print("load pressed")
