@tool
class_name LevelChunk extends Node2D

@export var config: LevelChunkConfig: set = set_config

@export var upload_btn: bool = false:
	set(_v):
		upload_btn = false
		var spawners: Array[Dictionary] = save_spawners()
		config.spawners_json = JSON.stringify(spawners)
		set_config(config)

@onready var spawners_root: Node2D = %SpawnersRoot
@onready var editor_hint_root: Node2D = %EditorHintRoot
@onready var editor_hint_level_left: ColorRect = %EditorHintRoot/LeftLevel
@onready var editor_hint_level_right: ColorRect = %EditorHintRoot/RightLevel


func _ready() -> void:
	editor_hint_root.visible = Engine.is_editor_hint()


func set_config(new_config: LevelChunkConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready

	if Engine.is_editor_hint():
		editor_hint_level_left.position.y = config.left_side_level * Global.TILE_SIZE
		editor_hint_level_right.position.y = config.right_side_level * Global.TILE_SIZE

	if config.spawners_json:
		clear_spawners()
		var spawners: Array = JSON.parse_string(config.spawners_json)
		load_spawners(spawners)

	spawn_entities()

func save_spawners() -> Array[Dictionary]:
	var spawners: Array[Dictionary] = []
	for spawner in spawners_root.get_children():
		spawners.append({
			"config_path": spawner.spawner_config.resource_path,
			"position_x": spawner.position.x,
			"position_y": spawner.position.y
		})
	return spawners


func load_spawners(spawners: Array) -> void:
	for spawner_dict: Dictionary in spawners:
		var inst: LevelChunkSpawner = LevelChunkSpawner.new()
		inst.spawner_config = load(spawner_dict["config_path"]) as LevelChunkSpawnerConfig
		inst.position.x = spawner_dict["position_x"]
		inst.position.y = spawner_dict["position_y"]
		spawners_root.add_child(inst)
		inst.spawn()


func clear_spawners() -> void:
	for spawner: LevelChunkSpawner in spawners_root.get_children():
		spawner.queue_free()


func clear_entities() -> void:
	for spawner: LevelChunkSpawner in spawners_root.get_children():
		for entity: Node2D in spawner.get_children():
			entity.queue_free()


func spawn_entities() -> void:
	for spawner: LevelChunkSpawner in spawners_root.get_children():
		spawner.spawn()
