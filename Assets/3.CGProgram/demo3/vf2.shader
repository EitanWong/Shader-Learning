Shader "Learning/CGPROGRAM/vf2"
{
    SubShader
    {
        pass{

            CGPROGRAM

            #pragma vertex vert

            #pragma fragment frag

            #include "sbin.cginc"

            


            void vert(in float2 objPos:POSITION,out float4 pos:POSITION,out fixed4 col:COLOR)
            {
                pos=float4(objPos,0,1);
                col=pos;
            }

            fixed4 func(fixed4 col);

            void frag(inout fixed4 col:COLOR)
            {
                //Func(col);
                col=func(col);
                // float arr[]={0.5,0.5,0.5};
                // col.x=Func2(arr);
            }

            fixed4 func (fixed4 col)
            {
                col.x=1;
                return col;
            }     

            ENDCG            
        }
    }
}
