﻿Shader "Unlit/MartixTest"
{
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work

			
			#include "UnityCG.cginc"

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

			
			float4x4 RM;
			
			v2f vert (appdata v)
			{
				v2f o;
				float4x4 _rm = mul(UNITY_MATRIX_MVP, RM);
				o.vertex = mul(_rm, v.vertex);
				
				
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = fixed4(1,1,1,1);
				// apply fog				
				return col;
			}
			ENDCG
		}
	}
}
