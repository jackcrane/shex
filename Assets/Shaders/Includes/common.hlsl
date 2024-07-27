namespace Common {
  float Luminance(float3 color) {
    return max(0.00001f, dot(color, float3(0.2127f, 0.7152f, 0.0722f)));
  }
}