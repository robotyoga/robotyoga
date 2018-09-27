uniform float phase;
uniform float freq;

out vec4 fragColor;
void main() {
  vec2 st = vUV.st * 2 - 1;
   // Converts between RGB and HSV color space

//  vec3 TDRGBToHSV(vec3 c);

  float value = st.y + phase;
  value += sin(st.x * freq);
  // value += st.x;
  vec3 hsv = vec3(value / 5 , 1.0, 1.0);
  // vec3 ;
  vec3 color = vec3(TDHSVToRGB(hsv));
  fragColor = vec4(color, 1.0);
}
