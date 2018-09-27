#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;
uniform float lineWidth;
uniform float steps;
uniform float angle;
uniform float height;

vec2 rotate(vec2 st, float angle) {
  return st * mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

float toLine(float value, float thickness) {
  return step(0., value + (thickness / 2)) - step(0., value - (thickness / 2));
}


out vec4 fragColor;
void main() {
  vec2 st = vUV.xy - vec2(0.5, 0.5);
  st.y -= (height / steps) / 2;
  float value = 0;
  for (int i = 0; i <= steps; i++) {
    st = rotate(st, angle);
    value += toLine(st.x, lineWidth);
    st = rotate(st, -2 * angle);
    value += toLine(st.x, lineWidth);
    st = rotate(st, angle);
    st.y += (height / steps) / 2;
    st = rotate(st, 2 * angle);
    value += toLine(st.x, lineWidth);
    st = rotate(st, -2 * angle);
    value += toLine(st.x, lineWidth);
    st = rotate(st, angle);
    st.y -= (height / steps);
    st = rotate(st, 2 * angle);
    value += toLine(st.x, lineWidth);
    st = rotate(st, -2 * angle);
    value += toLine(st.x, lineWidth);
    st.y += (height / steps) / 2;
    // st = rotate(st, angle);        
  }



  fragColor = vec4(1 - value + length(vUV.st * 2 - 1) * 2.5);
  // fragColor = vec4(length(st));
}
