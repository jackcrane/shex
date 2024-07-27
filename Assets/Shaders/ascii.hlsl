#include "Includes/common.hlsl"

struct appdata
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
};

struct v2f
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
};

sampler2D _MainTex;
float4 _MainTex_ST;

sampler2D _CharTex;  // Texture containing the ASCII characters
int _CharCount;

float _tilesX;
float _tilesY;
float _width;
float _height;
float _brightness;
int _charWidth;
int _charMapWidth;
int _charMapHeight;

v2f vert (appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    return o;
}

float4 frag(v2f i) : COLOR {
  // Sample the main texture at the new coordinates
  float4 col = tex2D(_MainTex, i.uv);

  // Calculate grayscale value
  float gray = saturate((col.r + col.g + col.b) / 3.0f);

  // Calculate the number of steps in grayscale based on character count
  float bandedGray = (float)(int)(gray * (_CharCount - 1)) / (_CharCount - 1);

  // Calculate tile size
  float2 normalizedTileSize = float2(1.0 / _tilesX, 1.0 / _tilesY); // Normalized tile size based on UV coordinates
  float2 tileSize = float2(_width / _tilesX, _height / _tilesY); // Tile size in pixels

  // Determine the current tile based on UV coordinates
  int2 currentTile = int2(floor(i.uv.x * _tilesX), floor(i.uv.y * _tilesY));

  // Calculate the tile coordinates
  float2 tileCoord = frac(i.uv / normalizedTileSize) * float2(_width / _tilesX, _height / _tilesY);
  float2 normalizedTileCoord = tileCoord / tileSize;

  // For debugging, paint the tileCoord.x and tileCoord.y to the screen as red and blue
  // return float4(normalizedTileCoord, 0, 1);

  // Sample multiple points within the tile
  float2 topLeftUV = currentTile * normalizedTileSize;
  float4 tileColor = tex2D(_MainTex, topLeftUV);
  float4 tileColorLuminance = Luminance(tileColor);
  float bandedTileGray = (float)(int)(tileColorLuminance * (_CharCount - 1)) / (_CharCount - 1);

  float charIndex = bandedTileGray * _CharCount;

  // return bandedTileGray;

  float2 charLocalCoordinates = normalizedTileCoord * _charWidth;
  float2 charTransformedCoordinates = charLocalCoordinates + float2(charIndex * 40 - 40, 0);
  int2 charTransformedCoordinatesInt = int2(charTransformedCoordinates);
  float2 normalizedCharTransformedCoordinates = charTransformedCoordinatesInt / float2(_charMapWidth, _charMapHeight);
  float4 charColor = tex2D(_CharTex, normalizedCharTransformedCoordinates);

  // Round the color to either white or black
  float4 grayCharColor = Luminance(charColor);
  charColor = grayCharColor;

  return charColor;

  // Original code for reference, comment out for debugging
  float clamped = bandedGray;

  return clamped;
}