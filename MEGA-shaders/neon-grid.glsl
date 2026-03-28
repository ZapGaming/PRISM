// 🔥 NEON GRID SHADER
uniform float time;
uniform vec2 resolution;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    float grid = step(0.98, fract(uv.x * 20.0)) + step(0.98, fract(uv.y * 20.0));
    float pulse = sin(time * 2.0) * 0.5 + 0.5;
    vec3 color = mix(
        vec3(0.102, 0.106, 0.149), // bg
        vec3(0.478, 0.631, 0.969), // neon blue
        grid * pulse
    );
    gl_FragColor = vec4(color, 1.0);
}
