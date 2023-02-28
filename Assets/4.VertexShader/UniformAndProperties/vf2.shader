Shader "Learning/VertexShader/vf2"
{
    Properties
    {
        _MainColor("MainColor",Color)=(1,1,1,1)
    }
    SubShader
    {
        pass{

            CGPROGRAM

            #pragma vertex vert

            #pragma fragment frag
            //引入sbin.cginc
            #include "sbin.cginc"

            float4 _MainColor;
            uniform float4 _SecondColor;
            

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

                //return _MainColor*0.5+_SecondColor*0.5;
                return lerp(_MainColor,_SecondColor,0.9);
            }

            ENDCG            
        }
    }
}
