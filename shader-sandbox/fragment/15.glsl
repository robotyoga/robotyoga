// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;
uniform float lineWidth;
uniform float maxDepth;
uniform float angle;

vec2 rotate(vec2 v, float a) {
	float s = sin(a);
	float c = cos(a);
	mat2 m = mat2(c, -s, s, c);
	return m * v;
}

out vec4 fragColor;
void main() {
  vec2 st = vUV.st;
  float depth = floor(st.y * maxDepth);
  st.x -= 0.5;
  st.y -= depth / maxDepth;
  st.x += atan(depth / maxDepth) * angle * angle;
  st = rotate(st, PI + (angle * depth));

  float value = abs(st.x);
  value = step(lineWidth, value);

  
  fragColor = vec4(1 - value);
  // fragColor = vec4(depth / maxDepth);
}
