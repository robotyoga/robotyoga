uniform float stretch;
uniform float steps;
uniform float pinchX;
uniform float pinchY;
uniform float cutoff;

out vec4 fragColor;
void main() {
  vec2 st = vUV.st * 2 - 1;
  st.y /= vUV.x + pinchX;
  st.x /= vUV.y + pinchY;
  st.x = abs(st.x);
  st.y = abs(st.y);
  float value = length(st * abs(st.x * stretch) * st.y - (fract(st.x * steps) / steps));
  if (value > cutoff) {
    value = 0.0;
  }
  vec3 color = vec3((value));
  fragColor = vec4(color, 1.0);
}
