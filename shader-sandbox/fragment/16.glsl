// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;
uniform float lineWidth;
uniform float radius;
uniform float angle;
uniform float exponent;

vec2 rotate(vec2 v, float a) {
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, -s, s, c);
	return m * v;
}

float circleLine(vec2 st, float radius, float thickness) {
  float offset = thickness / 2;
  float value = pow(length(st), exponent);
  return fract(value * (1 / thickness));
  return fract(smoothstep(radius - offset, radius, value)) - smoothstep(radius, radius + offset, value);
}

// float axes()

out vec4 fragColor;
void main() {
  vec2 st = vUV.st * 2 - 1;

  // st = rotate(st, -1 * (angle * PI));

  float value = circleLine(st, radius, lineWidth);
  float angleFromCenter = (atan(st.x, st.y) + PI) / TWO_PI;
  if (angle < 1) {
    value *= step(angle, angleFromCenter);
  } else {
    value -= step(angle - 1, angleFromCenter);
  }

  value = step(0.5, value);

  fragColor = vec4(value);
  // fragColor = vec4(angleFromCenter);
  // fragColor = vec4(1 - value);
}
