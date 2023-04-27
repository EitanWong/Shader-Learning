Shader "ShaderLearning/diffuse3"
{
    SubShader
    {
        Pass
        {
            tags{"LightMode"="ForwardBase"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"
        
            struct v2f
            {
                float4 vertex: POSITION;
                fixed4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                float3 N=normalize(mul(v.normal,(float3x3)unity_WorldToObject));
                float3 L=normalize(_WorldSpaceLightPos0);
                float ndotl=saturate(dot(N,L));
                o.color=_LightColor0*ndotl;

                float3 wpos=mul(unity_ObjectToWorld,v.vertex).xyz;

                o.color.rgb+=Shade4PointLights(unity_4LightPosX0,
                unity_4LightPosY0,
                unity_4LightPosZ0,
                unity_LightColor[0].rgb,unity_LightColor[1].rgb,
                unity_LightColor[2].rgb,unity_LightColor[3].rgb,
                unity_4LightAtten0,wpos,N);

                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                
                return i.color+UNITY_LIGHTMODEL_AMBIENT;
            }
            ENDCG
        }
    }
}
