Shader "ShaderLearning/ShaderLearning"
{
    Properties
    {
        _Shininess("Shininess",Range(1,64))=1
    }
    SubShader
    {

        Tags {"LightMode"="ForwardBase"}
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct v2f
            {
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;
            };


            float _Shininess;

            v2f vert (appdata_full v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                //计算世界坐标系下的光向量
                float3 L=normalize(WorldSpaceLightDir(v.vertex));
                //物体坐标系法线转为世界坐标系法线
                float3 N=UnityObjectToWorldNormal(v.normal);
                //计算世界空间下归一化的的摄像机观察方向
                float3 V=normalize(_WorldSpaceCameraPos-mul(unity_ObjectToWorld,v.vertex));
                //计算漫反射
                float diffuse=saturate(dot(L,N));
                //计算镜面高光，使用半角向量
                float specular=pow(saturate(dot(N,normalize(L+V))),_Shininess);
                //光源颜色分别和漫反射和镜面高光的强度系数相乘，最终赋给颜色
                o.color=_LightColor0*(diffuse+specular);
                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                //片远着色器，最终的颜色加上固定的环境光颜色
                return i.color+UNITY_LIGHTMODEL_AMBIENT;
            }
            ENDCG
        }
    }
}
