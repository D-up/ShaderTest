Shader "Unlit/VertexAnimation"
{
	Properties
	{
		_Amplitude("_Amplitude",float) = 0.3
		_AngularVelocity("_AngularVelocity",float) = 0.3
		_Speed("_Amplitude",float) = 0.3
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

			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float _Amplitude;
			float _AngularVelocity;
			float _Speed;
			float _SoundAngular;
			
			v2f vert (appdata v)
			{
				v2f o;
				/*_Amplitude = _Amplitude + _SoundAngular;
				float dis = (_Amplitude * sin(_AngularVelocity * v.vertex.x + _Speed *_Time.y));
				float disz = (_Amplitude * cos(_AngularVelocity * v.vertex.z + _Speed *_Time.y));

				v.vertex.y += dis+disz;*/

				float disxz = (_Amplitude * sin(-length(_AngularVelocity * v.vertex.xz) + _Speed *_Time.y));
				float disxz_cos = (_Amplitude * cos(-length(_AngularVelocity * v.vertex.xz) + _Speed *_Time.y));
				v.vertex.y += disxz+ disxz_cos;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				
				fixed4 col =i.uv;
				
				return col;
			}
			ENDCG
		}
	}
}
