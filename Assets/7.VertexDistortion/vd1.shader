Shader "ShaderLeaning/VertexDistortion/vf1"
{

    Properties{
        
        
    }
    SubShader{

        Pass{
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            

            struct v2f
            {
                float4 pos: POSITION;
                fixed4 col: COLOR;
            };

            v2f vert(appdata_base v)
            {
                v2f o;    
          
            float angle=length(v.vertex)*_SinTime.w*1.5;

            // angle=angle/8+1;
            // float4x4 my={
            //     cos(angle),0,sin(angle),0,
            //     0,1,0,0,
            //     -sin(angle),0,cos(angle),0,
            //     0,0,0,1
            // };
            // float4 p=mul(my,v.vertex);

            //优化以上代码
            // float x= x=v.vertex.x*cos(angle)+v.vertex.z*sin(angle);
            // float z=v.vertex.x*(-sin(angle))+v.vertex.z*cos(angle);
            //     v.vertex.x=x;
            //     v.vertex.z=z;
                
                float4x4 mx={
                    1,0,0,0,
                    0,cos(angle),-sin(angle),0,
                    0,sin(angle),cos(angle),0,
                    0,0,0,1
                };

                float4x4 my={
                    cos(angle),0,sin(angle),0,
                    0,1,0,0,
                    -sin(angle),0,cos(angle),0,
                    0,0,0,1
                };

                float4x4 mz={
                    cos(angle),-sin(angle),0,0,
                    sin(angle),cos(angle),0,0,
                    0,0,1,0,
                    0,0,0,1
                };
                
                v.vertex= mul(mz,mul(my,mul(mx,v.vertex)));

                o.pos=UnityObjectToClipPos(v.vertex);
                o.col=fixed4(0,1,1,1);
                
                return o;
            }

            fixed4 frag(v2f v):COLOR
            {
                return v.col;
            }
            ENDCG
        }
    }
}