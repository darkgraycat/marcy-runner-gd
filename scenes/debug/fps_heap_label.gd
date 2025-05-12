extends Label

func _process(_delta: float) -> void:
	var fps: float = Engine.get_frames_per_second()
	var stat_heap: int = OS.get_static_memory_usage() >> 20
	var mem_info: Dictionary = OS.get_memory_info()
	text = "FPS: %d\nHeap: %d MB\nMemInfo: %s" % [fps, stat_heap, mem_info]
