Shader "Custom/ascii"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _CharTex ("Char (RGB)", 2D) = "white" {}
        _CharCount ("Character Count", Int) = 30

        _tilesX ("Tiles X", Float) = 256
        _tilesY ("Tiles Y", Float) = 256

        _width ("Width", Float) = 1920
        _height ("Height", Float) = 1920

        _charWidth ("Char Width", Int) = 8

        _charMapHeight ("Char Map Height", Int) = 8
        _charMapWidth ("Char Map Width", Int) = 520

        _brightness ("Brightness", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "ascii.hlsl"
            ENDCG
        }
    }
}
