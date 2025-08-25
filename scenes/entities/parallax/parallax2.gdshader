shader_type canvas_item;

uniform float repeats: hint_range(1.0, 10.0, 0.5);
uniform float speed: hint_range(0.0, 10.0, 0.1);
uniform vec2 camera_scale;
uniform vec2 camera_position;
uniform vec3 color: source_color;

void vertex() {
	VERTEX.x = VERTEX.x * repeats;
}

void fragment() {
	float time_scale = TIME * speed;

	vec2 offset = camera_position * camera_scale / 100.0;
	vec2 uv = vec2(
        fract(UV.x * repeats + time_scale + offset.x),
        UV.y + offset.y
    );
    COLOR = texture(TEXTURE, uv) * vec4(color, 1.0);
}