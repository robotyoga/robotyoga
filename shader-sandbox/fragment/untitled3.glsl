// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;
uniform float parabolaHeight;
uniform float parabolaWidth;
uniform float scaleX;
uniform float scaleY;
uniform float sineMultiplier;
uniform float seconds;
uniform float scale;



out vec4 fragColor;
void main() {
  vec2 st = (vUV.xy * 2.0 - 1.0) * scale;
  st.x *= scaleX;
  st.y *= scaleY;
  st.y += 0.2;

  float x = abs(st.x);
  st.y -= (parabolaHeight * (x * x)) + (parabolaWidth * x);

  st *= parabolaWidth;
  float dist = pow(length(st), 1.7);
  
  if (dist > 1.0) {
    dist = 0;
  }

  dist -= pow(distance(vUV.st, vec2(0.5, 0.5)), 1.2);
  
  fragColor = vec4(dist);
}
