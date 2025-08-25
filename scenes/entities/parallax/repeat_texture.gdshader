shader_type canvas_item;

uniform vec2 repeat = vec2(1.0, 1.0);

void vertex() {
	VERTEX = VERTEX * repeat;
}

void fragment() {
	vec2 uv = vec2(
		fract(UV.x * repeat.x),
		fract(UV.y * repeat.y)
	);
	COLOR = texture(TEXTURE, uv);
}

