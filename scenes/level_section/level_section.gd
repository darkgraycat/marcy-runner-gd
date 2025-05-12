@tool
class_name LevelSection extends Node2D

@export var config: LevelSectionConfig = LevelSectionConfig.new():
	set = set_config

@onready var spawners_root: Node2D = %SpawnersRoot
@onready var editor_hint_root: Node2D = %EditorHintRoot
@onready var editor_hint_level_left: ColorRect = %EditorHintRoot/LeftLevel
@onready var editor_hint_level_right: ColorRect = %EditorHintRoot/RightLevel

func _ready() -> void:
	editor_hint_root.visible = Engine.is_editor_hint()
	# assert(config, "No resource is provided")

	# config.init()

	# prints("left", config.left_side)
	# prints("right", config.right_side)
	# prints("spawners", config.spawners)

	# prints(_save_children_to_json(spawners_root))

	# _load_children_from_json(data, spawners_root)

func set_config(new_config: LevelSectionConfig) -> void:
	config = new_config
	if not is_node_ready(): await ready
	if not config: return
	config.init()

	# Draw editor hints
	if Engine.is_editor_hint():
		editor_hint_level_left.position.y = config.left_level * Global.TILE_SIZE
		editor_hint_level_right.position.y = config.right_level * Global.TILE_SIZE

	# Reset LevelSection
	for spawner: LevelSectionSpawner in spawners_root.get_children():
		spawner.queue_free()

	# Instantiate spawners
	for item in config.spawners:
		var spawner: LevelSectionSpawner = load(item.script_path).new()
		spawner.name = item.name
		spawner.position.x = item.position_x
		spawner.position.y = item.position_y
		spawners_root.add_child(spawner)
		spawner._spawn()
