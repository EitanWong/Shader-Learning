Shader "Learning/CGPROGRAM/cg2"
{
    SubShader
    {
        pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            void vert(in float2 objPos:POSITION,out float4 pos:POSITION,out fixed4 col:COLOR)
            {
                pos=float4(objPos,0,1);
                
                if(pos.x<0 && pos.y<0)
                {
                    col=fixed4(1,0,0,1);//红色
                }
                else if(pos.x<0)
                {
                    col=fixed4(0,1,0,1);//绿色
                }
                else if(pos.y>0)
                {
                    col=fixed4(1,1,0,1);//黄色
                }
                else
                {
                    col=fixed4(0,0,1,1);//蓝色
                }
            }
            
            void frag(inout fixed4 col:COLOR)
            {
                // col=fixed4(1,0,0,1);
                int i=0;
                while (i<10)
                {
                    i++;
                }
                if(i==10)
                {
                    col=fixed4(0,0,0,1);
                }
                i=0;
                do
                {
                    i++;
                }while (i<10);
                if(i=10)
                {
                    col=fixed4(1,1,1,1);
                }
                // for(i=0;i<10000;i++)
                // {
                //     
                // }
                // if(i==10000)
                //     col=fixed4(0.5,0.5,0,1);
            }
            
            ENDCG            
        }
    }
}
