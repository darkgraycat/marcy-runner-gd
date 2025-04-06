class_name BackgroundRowParams extends Resource

@export var frame := 0
@export var offset := 0.0
@export var color := Color.WHITE

## Format: frame offset color[br]
## Example: 1 0.20 0xa53030ff[br]
func from_string(background_row_data: String) -> void:
	var colums := background_row_data.split(" ")
	frame = int(colums[0])
	offset = float(colums[1])
	color = Color.hex(colums[2].hex_to_int())
