shader_type canvas_item;
render_mode unshaded;

/** Size of CanvasItem this shader is applied to, in px. */
uniform vec2 canvas_size;
/** Size of base texture used for layers, in px. */
uniform vec2 texture_size;
/** Size of the single layer region on base texture, in px. */
uniform vec2 layer_size;
/** Base texture. */
uniform sampler2D base_texture;

uniform vec3 tints[8]: source_color;
uniform int variations[8];
uniform float offsets[8];
uniform float speeds[8];

void vertex() {
	VERTEX = VERTEX * vec2(2);
}

void fragment() {
	// Pre-calculate common values outside the loop
	vec2 scale_coef = canvas_size / texture_size;
	float layer_height_normalized = layer_size.y / texture_size.y;
	vec2 base_tiled_uv = UV * scale_coef;

	// Initialize final color
	vec4 final_color = vec4(0.0, 0.0, 0.0, 0.0);

	// Process only active layers
	for (int i = 0; i < 8; i++) {
		// Skip if variation is negative (disabled layer)
		if (variations[i] < 0) continue;

		// Calculate time-based horizontal movement
		float time_offset = TIME * speeds[i] + offsets[i];

		// Calculate tiled UV for this layer
		vec2 tiled_uv = vec2(
			fract(base_tiled_uv.x + time_offset),
			base_tiled_uv.y
		);

		// Calculate layer UV coordinates
		float layer_start_y = float(variations[i]) * layer_height_normalized;
		vec2 layer_uv = vec2(
			tiled_uv.x,
			layer_start_y + tiled_uv.y * layer_height_normalized
		);

		// Sample the texture for this layer
		vec4 layer_tex = texture(base_texture, layer_uv);

		// Skip transparent pixels early
		if (layer_tex.a <= 0.001) continue;

		// Apply tint to this layer
		vec4 tinted_layer = vec4(layer_tex.rgb * tints[i], layer_tex.a);

		// Alpha blending optimization - if current pixel is fully opaque,
		// we can skip further layers (front-to-back would be better for this)
		final_color = mix(final_color, tinted_layer, tinted_layer.a);

		// Early exit if we've reached full opacity
		if (final_color.a >= 0.999) break;
	}

	COLOR = final_color;
	//// scale coeficient
	//vec2 scale_coef = canvas_size / texture_size;
//
	//float time_scale = TIME * speeds[0];
//
	//vec2 tiled_uv = vec2(
		//fract(UV.x * scale_coef.x + time_scale),
		//UV.y * scale_coef.y - offsets[0]
	//);
//
	//vec4 tex = texture(base_texture, tiled_uv);
	//COLOR = vec4(tex.rgb * tints[0], tex.a);
}
