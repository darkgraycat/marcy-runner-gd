class_name LevelChunkConfig extends Resource

@export_group("Connection levels")
@export var left_level: float = 0.0
@export var right_level: float = 0.0

@export_group("Spawners")
@export var spawn_points: Array[LevelChunkSpawnPoint] = []
