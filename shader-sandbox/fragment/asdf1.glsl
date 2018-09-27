// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;
uniform float colorIncrement;
uniform float size;

out vec4 fragColor;
void main() {
  vec2 st = vUV.st * 2 - 1;
  vec3 color;
  float colorOffset = 0;
  for (int i = 0; i < 3; i++) {
    float value;
    value = length(st / size);
    color[i] = value * sin(colorOffset);
    colorOffset += colorIncrement;
  }
  fragColor = vec4(color, 1.0);
}
