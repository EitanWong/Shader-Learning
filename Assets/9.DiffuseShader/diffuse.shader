// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "ShaderLearning/diffuse"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"
        
            struct v2f
            {
                float4 vertex: POSITION;
                float3 normal: TEXCOORD1;
                fixed4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal=v.normal;
                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                float3 N=UnityObjectToWorldNormal(i.normal);
                float3 L=normalize(_WorldSpaceLightPos0);
                float ndotl=saturate(dot(N,L));
                return _LightColor0*ndotl+UNITY_LIGHTMODEL_AMBIENT;
            }
            ENDCG
        }
    }
}
