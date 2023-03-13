Shader "ShaderLearning/VertexShader/wave"
{
    Properties{
        _Amplitude("Amplitude",float)=1
        _Frequency("Frequency",Range(0,5))=1
        _Speed("_Speed",float)=1
    }

    SubShader
    {

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float _Amplitude;
            float _Frequency;
            float _Speed;

            struct v2f
            {
                float4 vertex : POSITION;
                float4 color : COLOR;
            };

            

            v2f vert (appdata_base v)
            {
                float up =sin(v.vertex.x)+_Time.y;
                // float4x4 m={
                //     1,0,0,0,
                //     0,sin(up)/8+0.5,0,0,
                //     0,0,1,0,
                //     0,0,0,1
                // };//由于Plane模型顶点的y值都为0和矩阵相乘的结果也都为0，所以定位没有进行移动
                // v.vertex=mul(m,v.vertex);


                //A*sin(w*x+t)
                v.vertex.y+=_Amplitude*sin((v.vertex.x+v.vertex.z)*_Frequency+_Time.y*_Speed);
                v.vertex.y+=_Amplitude*sin((v.vertex.x-v.vertex.z)*_Frequency+_Time.w*_Speed);

                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                o.color=lerp(fixed4(0,0.5,1,1),fixed4(1,1,1,1),v.vertex.y);
                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                return i.color;
            }
            ENDCG
        }
    }
}
