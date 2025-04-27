@tool
class_name LevelChunk extends Node2D

@export var configuration: LevelChunkConfig = LevelChunkConfig.new():
	set = set_configuration

@onready var entities_root: Node2D = %EntitiesRoot
@onready var editor_hint_root: Node2D = %EditorHintRoot
@onready var editor_hint_level_left: ColorRect = %EditorHintRoot/LeftLevel
@onready var editor_hint_level_right: ColorRect = %EditorHintRoot/RightLevel

func _ready() -> void:
	editor_hint_root.visible = Engine.is_editor_hint()

func set_configuration(new_configuration: LevelChunkConfig) -> void:
	configuration = new_configuration
	if not configuration: return printerr("%s: No configuration" % self)
	if not is_node_ready(): await ready

	if Engine.is_editor_hint(): _update_editor_hints()

	_clear_entities()
	configuration.spawn_points.map(_spawn_entity)

func _spawn_entity(spawn_point: LevelChunkSpawnPoint) -> void:
	if randf() > spawn_point.probability: return
	var entity: Node2D = spawn_point.spawner.scene.instantiate()
	if entity.has_method("spawn"):
		entity.spawn(spawn_point.spawner)
	entity.position = spawn_point.position * Global.TILE_SIZE
	entities_root.add_child(entity)

func _clear_entities() -> void:
	for node: Node2D in entities_root.get_children():
		node.queue_free()

func _update_editor_hints() -> void:
	editor_hint_level_left.position.y = configuration.left_level * Global.TILE_SIZE
	editor_hint_level_right.position.y = configuration.right_level * Global.TILE_SIZE
