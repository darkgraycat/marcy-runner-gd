class_name LevelChunkSpawnPoint extends Resource

@export var spawner: LevelChunkSpawner
@export var position: Vector2 = Vector2.ZERO
@export_range(0.0, 1.0, 0.01) var probability: float = 1.0
