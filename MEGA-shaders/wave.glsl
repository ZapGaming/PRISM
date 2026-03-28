// 🌊 PRISM WAVE SHADER
shader_type canvas_item;

uniform float time : hint_range(0, 10) = 0.0;
uniform float speed : hint_range(0.1, 5.0) = 1.0;
uniform vec4 color1 : hint_color = vec4(0.478, 0.631, 0.969, 1.0); // #7aa2f7
uniform vec4 color2 : hint_color = vec4(0.733, 0.604, 0.969, 1.0); // #bb9af7

void fragment() {
    vec2 uv = UV * 2.0 - 1.0;
    float wave = sin(uv.x * 3.14159 + time * speed) * 0.5 + 0.5;
    wave *= sin(uv.y * 3.14159 + time * speed * 0.5) * 0.5 + 0.5;
    COLOR = mix(color1, color2, wave);
}
