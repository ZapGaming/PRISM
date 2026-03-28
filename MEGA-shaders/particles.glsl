// ✨ FLOATING PARTICLES
uniform float time;
uniform vec2 resolution;

float circle(vec2 uv, vec2 pos, float r) {
    return 1.0 - smoothstep(r, r + 0.01, length(uv - pos));
}

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    vec3 bg = vec3(0.102, 0.106, 0.149);
    vec3 color = bg;
    
    for(int i = 0; i < 10; i++) {
        float fi = float(i);
        vec2 pos = vec2(
            fract(sin(fi * 123.45) * 0.5 + 0.5 + time * 0.1 * (fi * 0.1 + 0.5)),
            fract(cos(fi * 67.89) * 0.5 + 0.5 + time * 0.15 * (fi * 0.1 + 0.3))
        );
        float size = 0.02 + sin(time + fi) * 0.01;
        color += vec3(0.733, 0.604, 0.969) * circle(uv, pos, size);
    }
    
    gl_FragColor = vec4(color, 1.0);
}
