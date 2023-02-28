Shader "Learning/CGPROGRAM/cg1"
{
    
    SubShader
    {
        pass
        {
            CGPROGRAM


            // Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it uses non-square matrices
#pragma exclude_renderers gles
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members pos,uv)
#pragma exclude_renderers d3d11
            
            #pragma vertex vert
            #pragma fragment frag

            #define ONEFL4 float4(1,1,1,1);

            typedef float4 FL4;
            
            struct  v2f
            {
                float4 pos;
                float2 uv;
            };
            
            //顶点处理程序
            void vert(in float2 objPos:POSITION,out float4 pos:POSITION,out float4 col:COLOR)
            {
                pos=float4(objPos,0,1);
                col=pos;
            }
            //片元处理程序
            void frag(inout float4 col:COLOR)
            {
                fixed r=1;
                fixed g=0;
                fixed b=0;
                fixed a=1;
                col=fixed4(r,g,b,a);
                // col=float4(1,0,0,1);
                bool bl=true;
                col=bl?col:fixed4(0,1,0,1);

                float2 fl2=(1,0);
                float3 fl3=(1,0,1);
                float4 fl4=(1,0,0,1);
                // bool2 bl2=(true,false);
                // bool3 bl3=(true,false,true);
                // bool4 bl4=(true,false,false,true);

                /*声明一个2行2列的矩阵，并初始化
                 *[0,1]
                 *[0,1]
                 */
                float2x2 M2x2={0,1,0,1};
                /*声明一个2行4列的矩阵,并初始化
                 *[0,1,0,1]
                 *[1,1,0,0]
                 */
                // float2x4 M2x4={(0,1,0,1),(1,1,0,0)};
                //col=M2x4[0];//(0,1,0,1)
                //col=M2x4[1];//(1,1,0,0)

                // float2x4 M2x4={fl2,fl2,(1,1,0,0)};
                // float2x4 M2x4={fl4,(1,1,0,0)};
                // M2x4[0]=fl4;
                // M2x4[1]=(1,1,1,1);
                // M2x4[1]=(fl3,0);

                float arr[4]={1,0.5,0.5,1};

                arr[0];//1
                arr[1];//0.5
                col=float4(arr[0],arr[1],arr[2],arr[3]);

                col=ONEFL4;

                float fl=3;
                arr[0]=1;
                arr[1]=2;
                arr[2]=fl;
                v2f o;
                o.pos=float4(0,1,0,1);
                o.uv=float2(1,0);


                FL4 typeofFl4=FL4(0,1,3,2);
                float4 buildinFl4=FL4(1,2,3,4);
                FL4 typeFl4=float4(4,3,2,1);
            }
            ENDCG
        }
    }
}
