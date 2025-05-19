@tool
class_name LevelChunk extends Node2D

signal screen_exited(level_chunk: LevelChunk)

@export var config: LevelChunkConfig: set = set_config
@export var save_spawners_btn: bool = false:
	set(_v):
		save_spawners_btn = false
		save_spawners()

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = %VisibleOnScreenNotifier2D
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
		reset_spawners()
		load_spawners()


func save_spawners() -> void:
	var spawners: Array[Dictionary] = []
	for spawner in spawners_root.get_children():
		spawners.append({
			"name": spawner.name,
			"resource_path": spawner.spawner_config.resource_path,
			"position_x": spawner.position.x,
			"position_y": spawner.position.y
		})
	config.spawners_json = JSON.stringify(spawners)


func load_spawners() -> void:
	var spawners: Array = JSON.parse_string(config.spawners_json)
	for spawner_dict: Dictionary in spawners:
		var inst: LevelChunkSpawner = LevelChunkSpawner.new()
		inst.spawner_config = load(spawner_dict["resource_path"]) as LevelChunkSpawnerConfig
		inst.position.x = spawner_dict["position_x"]
		inst.position.y = spawner_dict["position_y"]
		inst.spawn()
		spawners_root.add_child(inst)
		if Engine.is_editor_hint():
			inst.owner = get_tree().edited_scene_root
		inst.name = spawner_dict["name"]


func reset_spawners() -> void:
	for spawner: LevelChunkSpawner in spawners_root.get_children():
		spawner.queue_free()


func get_left_x() -> float:
	return global_position.x


func get_right_x() -> float:
	return global_position.x + Global.VIEWPORT_WIDTH


func on_screen_exited() -> void:
	screen_exited.emit(self)
