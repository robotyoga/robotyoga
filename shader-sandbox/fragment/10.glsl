// http://www.pouet.net/prod.php?which=57245
// https://www.shadertoy.com/view/XsXXDn

uniform float seconds;
uniform float cutoff;
uniform float numerator;
uniform float distMultiplier;
uniform float timeMultiplier;

out vec4 fragColor;
void main() {
  vec2 uv = vUV.xy * 2 - 1;
  float dist = length(uv);


  uv += (uv / dist) * (sin(seconds) + 1.) * (sin((dist * distMultiplier) - seconds * timeMultiplier)) + 1;
  
  // vec2 value = (uv / dist);
  // vec2 value = (uv / dist) * (0.5);
  // vec2 value = (uv / dist) * (0.5) * (sin(dist * distMultiplier) + 1.);
  // vec2 value = (uv / dist) * (0.5) * (sin(dist * distMultiplier) + 1. - 1.1);
  // uv += (uv / dist) * (1.6) * (sin(dist * distMultiplier) + 1. - 10.1);
  
  float value = numerator / length(abs(mod(uv, 1.) - .5));
	fragColor=vec4(step(cutoff, value));
  // fragColor = vec4(value.x, value.x, 0, 1);
}