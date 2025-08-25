shader_type canvas_item;

void fragment() {
	vec3 base_color = COLOR.rgb * vec3(1.0, 1.0, 0.0);
	float len = length(base_color);
	float mask = step(0.4, len);

	COLOR.rgb = vec3(mask);
}
