class_name BackgroundParams extends Resource

@export_file("*.background.txt") var file_path: String:
	set(value):
		file_path = value
		from_string(Util.load_as_text(value))

var sky_color := Color.WHITE
var rows: Array[BackgroundRowParams] = [
	BackgroundRowParams.new(),
	BackgroundRowParams.new(),
	BackgroundRowParams.new(),
	BackgroundRowParams.new(),
	BackgroundRowParams.new(),
]

func from_string(background_data: String) -> void:
	var lines := background_data.split("\n")
	for idx in rows.size():
		rows[idx].from_string(lines[idx])

	sky_color = Color.hex(lines[5].hex_to_int())
