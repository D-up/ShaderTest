Shader "Custom/FragDiffuse"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
	
		

		Pass
		{
		Tags{ "RenderType" = "Opaque" "LightMode" = "ForwardBase" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			
			#include "UnityCG.cginc"
			#include "lighting.cginc"
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 normal:NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;

				float4 vertex : SV_POSITION;
				float4 normal:TEXCOORD1;
				float4 lightDir:TEXCOORD2;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.normal = v.normal;
				o.lightDir = v.vertex;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				
				fixed4 col = UNITY_LIGHTMODEL_AMBIENT;
			float3 N = UnityObjectToWorldNormal(i.normal.xyz);
			float3 L = normalize(WorldSpaceLightDir(i.lightDir));

			float R = max(0, dot(N, L));
				
			col += _LightColor0 * R;
			float3 wpos = mul(_Object2World, i.lightDir);

			col.rgb += Shade4PointLights(
				unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
				unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
				unity_4LightAtten0,
				wpos, N);

				return col;
			}
			ENDCG
		}
	}
}
