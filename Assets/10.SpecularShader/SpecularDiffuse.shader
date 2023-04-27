Shader "ShaderLearning/Diffuse/SpecularDiffuse"
{
    Properties
    {
        _Shininess("Shininess",Range(1,64))=1
    }
    SubShader
    {
        Tags { "LightMode"="ForwardBase" }
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
               fixed4 color: COLOR;
            };

            float _Shininess;

            v2f vert (appdata_full v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                
                float3 N=normalize(mul(unity_WorldToObject,v.normal));
                float3 L=normalize(_WorldSpaceLightPos0);
                float dotL=saturate(dot(N,L));
                o.color=_LightColor0*dotL;

                // L也可以替换为WorldSpaceLightDir(v.vertex)
                float3 R= reflect(-L,N);

                float3 V= normalize(WorldSpaceViewDir(v.vertex));

                float specularL= saturate(dot(V,R));

                specularL=pow(specularL,_Shininess);
                
                o.color+=_LightColor0*specularL;

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
