// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;
uniform float a;
uniform float b;
uniform float c;


out vec4 fragColor;
void main() {
  vec4 color = texture(sTD2DInputs[0], vUV.st);
  vec2 st = (vUV.xy * 2.0 - 1.0);

  float value;

  float dist = length(st);

  value = dist;
  value += color.r;
  value = step(a, value);
  value -= step(b, color.r);
  value -= step(c, dist);
  // value /= step(0.10, dist);
  // value = noise(st + vec2(0., yOffset));
  // value = step(0., st.y);

  fragColor = vec4(value);
  // fragColor = vec4(color);
}
