// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;
// uniform float scale;
// uniform float spacing;
// uniform float thickness;
// uniform float rotation;
// uniform float strobe;
// uniform float rotationSegments;
uniform int offset;
uniform float numBoxes = 55;

// YUV to RGB matrix
mat3 yuv2rgb = mat3(1.0, 0.0, 1.13983,
                    1.0, -0.39465, -0.58060,
                    1.0, 2.03211, 0.0);

mat3 rgb2yuv = mat3(0.2126, 0.7152, 0.0722,
                    -0.09991, -0.33609, 0.43600,
                    0.615, -0.5586, -0.05639);

float random (in vec3 normal, float index) {
  return fract(sin(dot(normal, vec3(12.9898, 78.233, 37.3333))) * (43758.5453123 + index + offset));
}

flat in int index;
in vec2 st;
in vec3 normal;
out vec4 fragColor;
void main() {
  // float value = random(abs(normal), float(index));
  // // value = step(0.7, value);
  // // value = length(st * 2 - 1);
  // // float value = length(st);
  // // value -= random(abs(normal), float(index));
  // value = step(float(index) / numBoxes, value);
  // fragColor = vec4(value);
  // // fragColor = vec4(abs(normal), 1);
  // vec2 fromOrigin = st * 2. - 1.;

  // float dist = length(fromOrigin);
  // float vertexRadiusMultiplier = TWO_PI / 4.0;
  // float angle = atan(fromOrigin.x, fromOrigin.y) + (rotation) * floor(dist * rotationSegments);
  // float section = floor(0.5 + (angle / vertexRadiusMultiplier));
  // dist *= cos((section * vertexRadiusMultiplier) - angle);
  // float thicknessMultiplier = sin(float(index) / numBoxes + (offset)) / 2 + 0.5;
  // dist = mod(dist * (1 / (scale - thicknessMultiplier)), spacing);
  // // dist /= float(index) / numBoxes;
  // float value = step(thickness, dist);
  // float value = step(thickness * thicknessMultiplier, dist);
  // fragColor = vec4(vec3(abs(strobe - value)), 1.0);
  float value = normal.z / normal.x * random(normal, float(index));
  value += 0.2;
  vec3 color = vec3(value);
  // vec3 color = abs(normal) * rgb2yuv + random(normal, float(index));
  float alpha = 1.0;
  fragColor = vec4(color, alpha);
  // fragColor = vec4(fract(abs(normal * offset)), alpha);
  // fragColor = vec4(sin(float(index) / numBoxes + offset) / 2 + 0.5);
}


