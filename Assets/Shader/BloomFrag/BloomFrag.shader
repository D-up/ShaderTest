Shader "Custom/BloomFrag"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Scale("PowScale",Range(0,8)) = 2
		_Color("Color",Color)=(1,1,1,1)
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" "Queue" = "Transparent"}
		LOD 100

		Pass
		{

			//Blend SrcAlpha OneMinusSrcAlpha
			Blend OneMinusSrcAlpha SrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			float _Scale;
			fixed4 _Color;
			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float4 pos:TEXCOORD1;
				float3 normal:TEXCOORD2;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata_base v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				o.normal = v.normal;
				o.pos = o.vertex;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				//fixed4 col = tex2D(_MainTex, i.uv);

				float3 N = normalize(mul(i.normal.xyz,(float3x3)_World2Object));
				float4 wpos = mul(_Object2World, i.pos);
				float3 V = normalize(UnityWorldSpaceViewDir(wpos));
				float bright =1- max(0, dot(N, V));

				bright = pow(bright, _Scale);

				fixed4 col = _Color * bright;



				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}

	}
			FallBack "Diffuse"
}
