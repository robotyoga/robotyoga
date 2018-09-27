// forked from
// http://www.iquilezles.org/www/articles/voronoilines/voronoilines.htm

#define ANIMATE

uniform float seconds;
uniform float gridSize;
uniform float initialMin;
uniform float exponent;

vec2 hash2(vec2 p) {
	return fract(
    sin(
      vec2(
        dot(p, vec2(127.1,311.7)),
        dot(p, vec2(269.5,183.3))
      )
    ) * 43758.5453);
}

float voronoi(vec2 x) {
  vec2 n = floor(x);
  vec2 f = fract(x);

  float minDist = initialMin;
  
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      vec2 g = vec2(float(i), float(j));
      vec2 offset = hash2(n + g);

      #ifdef ANIMATE
        offset = 0.5 + 0.5 * sin(seconds + 6.2831 * offset);
      #endif

      vec2 point = g + offset - f;

      float dist = pow(length(point), exponent);

      if (dist < minDist) {
        minDist = dist;
      }
    }
  }
  return minDist;
}

out vec4 fragColor;
void main() {
  vec2 point = vUV.xy;
  float value = voronoi(point * gridSize);
	fragColor = vec4(value);
}
