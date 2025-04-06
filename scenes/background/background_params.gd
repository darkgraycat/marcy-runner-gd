class_name BackgroundParams extends Resource

@export_file("*.background.txt") var file_path: String:
	set(value):
		file_path = value
		from_string(Utils.load_as_text(value))

var sky_color := Color.WHITE

var background_row0 := BackgroundRowParams.new()
var background_row1 := BackgroundRowParams.new()
var background_row2 := BackgroundRowParams.new()
var background_row3 := BackgroundRowParams.new()
var background_row4 := BackgroundRowParams.new()

func from_string(background_data: String) -> void:
	var lines := background_data.split("\n")
	background_row0.from_string(lines[0])
	background_row1.from_string(lines[1])
	background_row2.from_string(lines[2])
	background_row3.from_string(lines[3])
	background_row4.from_string(lines[4])
	sky_color = Color.hex(lines[5].hex_to_int())
