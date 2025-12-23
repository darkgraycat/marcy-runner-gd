shader_type canvas_item;

uniform vec4 outline_color: source_color = vec4(0,0,0,1);
uniform float outline_size: hint_range(1,10) = 2.0;

void fragment() {
    vec2 t = outline_size / vec2(textureSize(TEXTURE,0));
    float a = texture(TEXTURE, UV).a;
    float o = max(
        max(texture(TEXTURE, UV + vec2(t.x,0)).a, texture(TEXTURE, UV - vec2(t.x,0)).a),
        max(texture(TEXTURE, UV + vec2(0,t.y)).a, texture(TEXTURE, UV - vec2(0,t.y)).a)
    );
    COLOR = (a > 0.0) ? texture(TEXTURE, UV) : (o > 0.0 ? outline_color : vec4(0));
}

