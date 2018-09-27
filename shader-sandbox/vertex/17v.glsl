// Reference to
// http://thndl.com/square-shaped-shaders.html

#define PI 3.14159265359
#define TWO_PI 6.28318530718
//;


 void main()
 {
    // P is the position of the current vertex
    // TDDeform() will return the deformed P position, in world space.
    // Transform it from world space to projection space so it can be rasterized
    gl_Position = TDWorldToProj(TDDeform(P));
 }