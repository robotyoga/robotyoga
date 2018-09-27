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
  // // float value = step(thickness * thicknessMultiplier, dist);
  // fragColor = vec4(vec3(abs(strobe - value)), 1.0);
  vec2 uv = st * 2 - 1;
  float value = float(index) / numBoxes;
  value *= pow(length(uv), sin(float(index + offset)));
  // value = step(0.4, value);
  if (mod(index, offset) == 0) {
    value -= normal.z;
  }
  if (mod(index + 33, offset) == 0) {
    value += normal.x;
  }
  if (mod(index + 66, offset) == 0) {
    value += normal.y;
  }
  vec3 color = vec3(value);
  float alpha = 1.0;
  fragColor = vec4(color, alpha);
  // fragColor = vec4(sin(float(index) / numBoxes + offset) / 2 + 0.5);
}


