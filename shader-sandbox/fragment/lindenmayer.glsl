// Copyright Max Sills 2016, licensed under the MIT license.
//
// Real time lindenmayer systems.
// Reference: http://algorithmicbotany.org/papers/abop/abop-ch1.pdf
// Figures d, e, f from pg. 25. "Bracketed OL systems".
// 
// Inspired by Knighty's using base n encodings to explore
// n-ary IFS. Bounding volumes are trash.
//
// Enormous thanks to iq for numerous bugfixes and optimizations!
// https://www.shadertoy.com/view/XtyGR1

#define PI 3.14159

//;
uniform float windValueA;
uniform float windValueB;
uniform float windMagnitudeA;
uniform float windMagnitudeB;
uniform float sharpness;
uniform float xOffset;
uniform float yOffset;

mat3 Rot(float angle) {
  float c = cos(angle);
  float s = sin(angle);
    
  return mat3(
    vec3(c, s, 0),
    vec3(-s, c, 0),
    vec3(0, 0, 1)
  ); 
}

mat3 Disp(vec2 displacement) {
  return mat3(
    vec3(1, 0, 0),
    vec3(0, 1, 0),
    vec3(displacement, 1)
  ); 
}

float sdCappedCylinder(vec2 p, vec2 h) {
  p -= vec2(0., h.y);
  vec2 d = abs(vec2(length(p.x), p.y)) - h;
  return min(max(d.x, d.y), 0.0) + length(max(d, 0.0));
}

float tree(vec2 pt) {
  mat3 posR = Rot(-(20. / 360.) * 2. * PI);
  mat3 negR = Rot(20. / 360. * 2. * PI);
  
  const int depth = 6;
  const int branches = 3; 
  int maxDepth = int(pow(float(branches), float(depth)));
  float len = 2.0;
  float wid = .001;
  pt = pt + vec2(0, 2);  
  mat3 m1 = posR * Disp(vec2(0, -len));
  
  float trunk = sdCappedCylinder(pt - vec2(0., 0.), vec2(wid, len));
  float d = 500.;
  
  int c = 0; // Running count for optimizations
  
  for (int count = 0; count <= 100; ++count) {
    int off = int(pow(float(branches), float(depth)));

    vec2 pt_n = pt;
    for (int i = 1; i <= depth; ++i) {
      float l = len / pow(2., float(i));

      off /= branches;
      int dec = c / off;
      int path = dec - branches * (dec / branches); //  dec % kBranches

      mat3 mx;
      if (path == 0) {
        mx = posR * Disp(vec2(0, -2. * l));
      } else if (path == 1) {
        mat3 wind = Rot(windMagnitudeA * windValueA);
        mx = wind * posR * Disp(vec2(0, -4. * l));
      } else if (path == 2) {
        mat3 wind = Rot(windMagnitudeB * windValueB);
        mx = wind * negR * Disp(vec2(0, -4. * l));
      }

      pt_n = (mx * vec3(pt_n, 1)).xy;
      float y = sdCappedCylinder(pt_n, vec2(wid, l));
      
      // Early bail out. Bounding volume is a noodle of radius
      // 2. * l around line segment.
      if (y - 2.0 * l > 0.0) { 
        c += off-1; 
        break; 
      }
      
      d = min(d, y);
    }

    ++c;
    if (c > maxDepth) {
      break;
    } 
  }
  return min(d, trunk);
}

out vec4 fragColor;
void main() {
  vec2 uv = vUV.xy * 2.0 - 1.0;
  uv.x += xOffset;
  uv.y += yOffset;
  uv *= 3.;
  
  float l = tree(uv - vec2(-5., 0.));
  
  float t = clamp(l, 0.0, 5.);
  t *= sharpness;
  vec4 bg = vec4(0);
  vec4 fg = vec4(1);
  // fragColor = mix(bg, fg, 1. - t);
  // fragColor = vec4(1 - l);
  fragColor = vec4(vec3(t), 1.);
  // fragColor = vec4(uv.x);
}