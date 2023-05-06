Shader "ShaderLearning/ShadowCaster/VertexShadowBlinnPhongShader"
{
    Properties
    {
        _MainColor ("MainColor", Color) = (1,1,1,1)
        _SpecularColor ("SpecularColor", Color) = (0.5,0.5,0.5,1)
        _Shineness("Shineness",Range(1,32))=8
    }
    SubShader
    {
        Pass
        {
            Tags { "LightMode"="ForwardBase" }
            CGPROGRAM
            #pragma multi_compile_fwdbase
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
                float4 vertex: POSITION1;
                LIGHTING_COORDS(1,2)
            };

            fixed4 _MainColor;
            fixed4 _SpecularColor;
            float _Shineness;

            v2f vert (appdata_base v)
            {
                v2f o;
                o.pos=UnityObjectToClipPos(v.vertex);
                o.normal=v.normal;
                o.vertex=v.vertex;
                TRANSFER_VERTEX_TO_FRAGMENT(o)

                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                //环境光颜色 
                fixed4 col=UNITY_LIGHTMODEL_AMBIENT;
                //模型坐标系下的法线转位世界坐标系下
                float3 N=UnityObjectToWorldNormal(i.normal);
                //获取世界坐标系下的光照方向
                float3 L=normalize(WorldSpaceLightDir(i.vertex));
                //计算漫反射
                float diffuse=saturate(dot(L,N)); 
                //计算摄像机观察视角向量
                float3 V=normalize(WorldSpaceViewDir(i.vertex));
                //计算镜面高光,使用半角向量
                float specular=pow(saturate(dot(N,normalize(L+V))),_Shineness);
                //叠加上漫反射与镜面高光的颜色乘上光照颜色
                col+= _LightColor0*((_MainColor*diffuse)+(_SpecularColor*specular));
                //计算世界坐标系下的顶点位置 
                float3 wpos=mul(unity_ObjectToWorld,i.vertex).xyz;
                //计算4个点光源颜色
                col.rgb+=Shade4PointLights(unity_4LightPosX0,
                unity_4LightPosY0,
                unity_4LightPosZ0,
                unity_LightColor[0].rgb,unity_LightColor[1].rgb,
                unity_LightColor[2].rgb,unity_LightColor[3].rgb,
                unity_4LightAtten0,wpos,N);

                float atten = LIGHT_ATTENUATION(i);

                col.rgb*=atten;

                return col;
            }
            ENDCG
        }
        Pass
        {
            Blend One One//使用Blend混合 帧缓冲里的结果 默认方法为Add
            Tags { "LightMode"="ForwardAdd" }// ForwarAdd 附加支持逐像素光以及聚光灯
            CGPROGRAM
            //使用
            #pragma multi_compile_fwdadd_fullshadows
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
                float4 vertex: POSITION1;

                LIGHTING_COORDS(1,2)
            };

            fixed4 _MainColor;
            fixed4 _SpecularColor;
            float _Shineness;

            v2f vert (appdata_base v)
            {
                v2f o;
                o.pos=UnityObjectToClipPos(v.vertex);
                o.normal=v.normal;
                o.vertex=v.vertex;
                TRANSFER_VERTEX_TO_FRAGMENT(o)

                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                //环境光颜色 

                //模型坐标系下的法线转位世界坐标系下
                float3 N=UnityObjectToWorldNormal(i.normal);
                //获取世界坐标系下的光照方向
                float3 L=normalize(WorldSpaceLightDir(i.vertex));
                //计算漫反射
                float diffuse=saturate(dot(L,N)); 
                //计算摄像机观察视角向量
                float3 V=normalize(WorldSpaceViewDir(i.vertex));
                //计算镜面高光,使用半角向量
                float specular=pow(saturate(dot(N,normalize(L+V))),_Shineness);
                //叠加上漫反射与镜面高光的颜色乘上光照颜色
                fixed4 col = _LightColor0*((_MainColor*diffuse)+(_SpecularColor*specular));
                // //计算世界坐标系下的顶点位置 
                float3 wpos=mul(unity_ObjectToWorld,i.vertex).xyz;
                //计算4个点光源颜色
                col.rgb+=Shade4PointLights(unity_4LightPosX0,
                unity_4LightPosY0,
                unity_4LightPosZ0,
                unity_LightColor[0].rgb,unity_LightColor[1].rgb,
                unity_LightColor[2].rgb,unity_LightColor[3].rgb,
                unity_4LightAtten0,wpos,N);

                float atten = LIGHT_ATTENUATION(i);

                col.rgb*=atten;

                return col;
            }
            ENDCG
        }

    }
    Fallback "Diffuse"
}
