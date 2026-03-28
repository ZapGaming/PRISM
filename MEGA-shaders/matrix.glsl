// 💚 MATRIX RAIN SHADER
uniform float time;
uniform vec2 resolution;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void main() {
    vec2 uv = gl_FragCoord.xy / resolution;
    float col = floor(uv.x * 40.0);
    float speed = random(vec2(col, 0.0)) + 0.5;
    float y = fract(uv.y + time * speed);
    float char = step(0.9, random(vec2(col, floor(y * 30.0))));
    vec3 green = vec3(0.153, 0.945, 0.467) * char * step(0.1, y) * step(y, 0.9);
    gl_FragColor = vec4(green, 1.0);
}
