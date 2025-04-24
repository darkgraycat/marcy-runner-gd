class_name BackgroundConfig extends Resource

@export_group("Colors")
@export var sky_color: Color = Color.WHITE
@export var sun_color: Color = Color.WHITE
@export var row0_color: Color = Color.WHITE
@export var row1_color: Color = Color.WHITE
@export var row2_color: Color = Color.WHITE
@export var row3_color: Color = Color.WHITE
@export var row4_color: Color = Color.WHITE

@export_group("Sprites")
@export var sun_frame: int = 0
@export var row0_frame: int = 0
@export var row1_frame: int = 0
@export var row2_frame: int = 0
@export var row3_frame: int = 0
@export var row4_frame: int = 0

@export_group("Offsets")
@export_range(0, 1.0, 0.01) var sun_offset: float = 0.0
@export_range(0, 1.0, 0.05) var row0_offset: float = 0.20
@export_range(0, 1.0, 0.05) var row1_offset: float = 0.25
@export_range(0, 1.0, 0.05) var row2_offset: float = 0.30
@export_range(0, 1.0, 0.05) var row3_offset: float = 0.40
@export_range(0, 1.0, 0.05) var row4_offset: float = 0.25
