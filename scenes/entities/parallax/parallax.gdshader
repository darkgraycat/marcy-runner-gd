shader_type canvas_item;

uniform vec2 camera_offset;
uniform vec2 screen_size = vec2(320.0, 180.0);
uniform vec2 variation_size = vec2(128.0, 32.0);

uniform sampler2D base_texture: source_color;
uniform int layers_count: hint_range(1, 8) = 4;
uniform int variation_count;

uniform vec4 tints[8]: source_color;
uniform int variations[8];
uniform float speeds[8];
uniform float offsets[8];

void fragment() {
	vec2 base_uv = UV * (screen_size / variation_size);
    COLOR = vec4(0.0, 0.0, 0.0, 0.0);

    float variation_height = 1.0 / float(variation_count);

    for (int i = 0; i < layers_count && i < 8; i++) {
        // Calculate parallax UV
        vec2 parallax_uv = fract(base_uv + camera_offset * speeds[i] + vec2(0.0, offsets[i]));

        // Map to the specific variation strip
        int variation_index = variations[i];
        float variation_y_start = float(variation_index) * variation_height;

        // Final UV: full width, but only the height slice for this variation
        vec2 final_uv = vec2(parallax_uv.x, variation_y_start + parallax_uv.y * variation_height);

        // Sample and composite
        vec4 sample = texture(base_texture, final_uv);
        vec4 tinted = sample * tints[i];
        COLOR = mix(COLOR, tinted, tinted.a);
    }
}
