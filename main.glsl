#version 330 core

vec3 palette(float t) {
  vec3 a = vec3(0.5, 0.5, 0.5);
  vec3 b = vec3(0.5, 0.5, 0.5);
  vec3 c = vec3(1.0, 1.0, 1.0);
  vec3 d = vec3(0.263, 0.416, 0.557);
  return a + b * cos(6.28318 * (c * t + d));
}

void main() {
  vec2 uv = gl_FragCoord.xy / iResolution.xy * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;
  float d0 = length(uv);
  vec4 final_color = vec4(0.0);

  for (float i = 0.0; i < 4.0; i++) {
    uv = fract(uv * 1.6) - 0.5;

    float d = length(uv) * exp(-length(d0));

    float s = sin(d * 30.0 + iTime * 2.0);
    s = (s + 1.0) / 2.0;

    s = 0.02 / s;
    s = pow(s, 1.2);

    vec3 color = palette(d0 + i * 0.4 + iTime / 4.0);
    final_color += vec4(color * s, 1.0);
  }

  gl_FragColor = final_color;
}