Shader "Custom/VertexColor_Y"
{
	Properties
	{
		_Radius("Radius",Range(0,10))=3
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "DisableBatching"="true"}
		

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"



			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 col : TEXCOORD0;
				float4 pos:TEXCOORD1;
			};

			float _Radius;
			
			v2f vert (appdata_base v)
			{
				v2f o;				
				
				float3 centerPos = v.vertex.xyz;// mul(_Object2World, v.vertex);
				
				float dis = _Radius - length(centerPos.xz) + _SinTime.y;
				dis = dis < 0 ? 0 : dis;
				
				float4 uppos = float4(centerPos.x, centerPos.y+dis, centerPos.z,1) ;
				o.vertex = mul(UNITY_MATRIX_MVP, uppos);
				o.pos = v.texcoord;
				o.col = fixed4(centerPos.y, centerPos.y, centerPos.y, 1);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float4 col= i.pos;				
				return col;
			}
			ENDCG
		}
	}
		Fallback "Diffuse"
}
