// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
uniform float scale;
uniform float spacing;
uniform float thickness;
uniform float rotation;
uniform float strobe;
uniform float numSides;
uniform float rotationSegments;



out vec4 fragColor;
void main()
{
  // map this pixel's vector to range from -1 to 1
  // this places our origin in the center
  vec2 fromOrigin = vUV.st * 2. - 1.;


  // start by getting the distance from the origin
  // this is one way to make a perfect circle
  float dist = length(fromOrigin);

  // to make a polygon, we need to sculpt this distance
  // such that it increases at the vertices,
  // stays the same at the midpoint of the edges,
  // and makes a straight line between those points

  // to do this, need to know by how much we should multiply
  // the distance at the vertices of the polygon
  // this number will get closer to zero as number of sides increases
  // because the polygon will become more like a circle

  // the radius of the polygon's circumcircle (the polygon's radius)
  // is some multiple of the radius of its incircle (apothem)
  // here's how we find that multiplier
  float vertexRadiusMultiplier = TWO_PI / float(numSides);

  // this pixel's vector might intersect with a vertex, an edge midpoint, or somewhere between
  // we need to know the angle of the current pixel from the origin
  // atan gets us something between -PI and PI
  float angle = atan(fromOrigin.x, fromOrigin.y) + rotation * floor(dist * rotationSegments);
  // float angle = atan(fromOrigin.x, fromOrigin.y) + rotation;
  
  // the last thing we need to know is which section of the polygon we're in
  // for a square, we could call them "quadrants" and the number would range from -2 to +2
  // for a pentagon, this number ranges between -2 and +3
  float section = floor(0.5 + (angle / vertexRadiusMultiplier));
  
  // now we have all the information we need sculpt the distance field
  dist *= cos((section * vertexRadiusMultiplier) - angle);
  dist = mod(dist * (1 / scale), spacing);
  

  float value = step(thickness, dist);
  // value /= length(fromOrigin);
  // float value = smoothstep(0, 1, dist);
  // float value = dist;
  fragColor = vec4(vec3(abs(strobe - value)), 1.0);
}
