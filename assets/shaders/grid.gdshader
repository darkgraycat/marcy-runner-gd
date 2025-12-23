shader_type canvas_item;

uniform vec2 rect_size = vec2(512, 512);
uniform vec2 cell_size = vec2(128, 128);
uniform vec4 line_color : source_color = vec4(0.8, 0.6, 0.4, 0.5);
uniform float line_width = 1.0;

void fragment() {
	vec2 local_pos = UV * rect_size;

	int chunk_x = int(round(local_pos.x / cell_size.x));
	int chunk_y = int(round(local_pos.y / cell_size.y));

	vec2 line = mod(local_pos, cell_size);	
	bool is_line = 
		line.x < line_width ||
		line.y < line_width ||
		local_pos.x >= rect_size.x - line_width || // right edge
		local_pos.y >= rect_size.y - line_width;   // bottom edge
	
	COLOR = is_line ? line_color : vec4(0);
}
