// 🌌 AURORA BOREALIS
uniform float time;
uniform vec2 resolution;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    float wave1 = sin(uv.x * 5.0 + time) * 0.5 + 0.5;
    float wave2 = sin(uv.x * 3.0 - time * 0.7) * 0.5 + 0.5;
    float wave3 = sin(uv.x * 7.0 + time * 1.3) * 0.5 + 0.5;
    vec3 color1 = vec3(0.733, 0.604, 0.969); // purple
    vec3 color2 = vec3(0.478, 0.631, 0.969); // blue
    vec3 color3 = vec3(0.561, 0.922, 0.753); // mint
    vec3 final = mix(color1, color2, wave1) * wave2 + color3 * wave3 * 0.3;
    gl_FragColor = vec4(final, 1.0);
}
