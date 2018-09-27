// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;
uniform float multiplier;
uniform float gridSize;
uniform float falloff;

float random(vec2 st) {
  return fract(sin(dot(st, vec2(12.9898, 78.233))) * multiplier);
}

out vec4 fragColor;
void main()
{
  vec2 st = (vUV.xy * 2.0 - 1.0) / 2.0;
  // vec2 st = (vUV.xy * 2.0 - 1.0);
  st *= gridSize;
  float dist = pow(length(st), 1 / falloff);
  vec2 tileInt = floor(st);
  vec2 tileFract = fract(st);
  
  fragColor = vec4(vec3(random(tileInt) * step(tileFract.y, tileFract.x)), 1.0);
  // fragColor = vec4(dist);
}
