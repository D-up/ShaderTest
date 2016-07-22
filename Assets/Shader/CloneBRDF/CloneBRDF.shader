Shader "Custom/CloneBRDF"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "LightMode"="ForwardBase" }
		

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

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
				float3 normal : NORMAL;
				float3 lightDir : TEXCOORD1;
				float3 viewDir:TEXCOORD2;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
//				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				float4 modelMatrixInverse = mul(v.normal, _World2Object);
				float3 normalDirection = modelMatrixInverse;
				float3 lightDirection = _WorldSpaceLightPos0;
				o.normal = normalDirection;
				o.lightDir = lightDirection;
				o.viewDir = _WorldSpaceCameraPos;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{

				float4 col = float4(1,1,1,1);				
				
				float diff = max(0,dot(normalize(i.normal), normalize(i.lightDir)));
				float hLambert = diff*0.5 + 0.5;
				float rimLight= max(0, dot(normalize(i.normal), normalize(i.viewDir)));
				float hrimLight = rimLight*0.5 + 0.5;
				col.rgb=tex2D(_MainTex, float2(hLambert, hrimLight)).rgb * _LightColor0;
				return col;

			}
			ENDCG
		}
	}
}
