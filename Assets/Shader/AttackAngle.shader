Shader "Unlit/AttackAngle"
{
	Properties
	{
		_COL1("Col1",Color) = (1,1,1,1)
		_COL2("Col2",Color) = (1,1,1,1)
		_COL3("Col3",Color) = (1,1,1,1)
		_COL4("Col4",Color) = (1,1,1,1)
		_COL5("Col5",Color) = (1,1,1,1)

		_Angle("AttackAngle",Range(0,270))=45
		_AttackDis("AttDis",float)=3
		
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
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;				
				float4 vertex : SV_POSITION;
				fixed4 col : COLOR0;
				float4 pos:TEXCOORD1;
			};

			fixed4 _COL1;
			fixed4 _COL2;
			fixed4 _COL3;
			fixed4 _COL4;
			fixed4 _COL5;
			float _Angle;
			float _AttackDis;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.pos = v.vertex;
				
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col;
			float _halfangle = _Angle / 2;
			float2 _foward = float2(0, 2);
			col = float4(0, 0, 0, 0);

			if (i.pos.x > -0.1 && i.pos.x <0.1)
			{
				if (i.pos.z > 0 && i.pos.z < 5)
					col = _COL1;
			}

			if (length(i.pos.xz) < _AttackDis)
			{
				if (degrees(acos(dot(normalize(_foward) , normalize(i.pos.xz)))) < _halfangle)
					col = _COL5;
			}
			
				
				return col;
			}
			ENDCG
		}
	}
}
