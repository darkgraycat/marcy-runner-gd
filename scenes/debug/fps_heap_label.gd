extends Label

func _process(_delta: float) -> void:
	var fps: float = Engine.get_frames_per_second()
	var stat_heap: int = OS.get_static_memory_usage() >> 20
	text = "FPS: %d\nHeap: %d MB" % [fps, stat_heap]
