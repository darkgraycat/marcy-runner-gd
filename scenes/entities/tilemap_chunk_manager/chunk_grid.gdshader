shader_type canvas_item;

/** Base tile size in pixels */
uniform vec2 pixels_per_tile = vec2(16, 16);
/** Chunk size in base tiles */
uniform vec2 tiles_per_chunk = vec2(8, 8);
/** Size of the color rect */
uniform vec2 rect_size = vec2(1024, 1024);
/** Color used for visual grid */
uniform vec4 primary_color: source_color = vec4(0.5, 0.5, 0.2, 0.3);
/** Color used for visual grid */
uniform vec4 secondary_color: source_color = vec4(0.2, 0.5, 0.5, 0.3);
/** Supportive grid color */
uniform vec4 line_color : source_color = vec4(0.2, 0.2, 0.2, 0.5);
uniform float line_width = 1.0;

void fragment() {
	vec2 chunk_px = pixels_per_tile * tiles_per_chunk;
	vec2 local_pos = UV * rect_size;

	int chunk_x = int(floor(local_pos.x / chunk_px.x));
	int chunk_y = int(floor(local_pos.y / chunk_px.y));
	bool checker = (chunk_x + chunk_y) % 2 == 0;

	vec4 base_color = checker ? primary_color : secondary_color;
	vec2 line = abs(mod(local_pos, chunk_px));

	COLOR = line.x < line_width || line.y < line_width
		? line_color
		: base_color;
}
