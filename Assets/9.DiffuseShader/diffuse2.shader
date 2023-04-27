Shader "ShaderLearning/diffuse2"
{
    SubShader
    {
        Pass
        {
            tags{"LightMode"="Vertex"}
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
                o.color.rgb=ShadeVertexLights(v.vertex,v.normal);
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
