Shader "Learning/VertexShader/vf1"
{
    SubShader
    {
        pass{

            CGPROGRAM

            #pragma vertex vert

            #pragma fragment frag
            //引入sbin.cginc
            #include "sbin.cginc"

            typedef struct {
                float4 pos:POSITION;
                float2 objPos:TEXCOORD0;
                fixed4 col:COLOR;
            }v2f;

 
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos=float4(v.pos,0,1);
                o.objPos=float2(1,0);
                o.col=v.col;
                return o;
            }

            fixed4 frag(v2f IN):COLOR
            {
                // float4 col=(0,0,0,1);
                // float arr[]={0.5,0.5};
                // col.y=Func2(arr);
                return IN.col;
            }


            ENDCG            
        }
    }
}
