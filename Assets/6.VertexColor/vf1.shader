// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Learning/VertexColor/vf1"
{
    SubShader
    {
        pass{

            CGPROGRAM

            #pragma vertex vert

            #pragma fragment frag
            
            #include "UnityCG.cginc"
            

            struct v2f{
                float4 pos:POSITION;
                fixed4 col:COLOR;
            };



            v2f vert(appdata_base v)
            {
                v2f o;
            
                o.pos=UnityObjectToClipPos(v.vertex);
                
                float4 wpos=mul(unity_ObjectToWorld,v.vertex);
                if(wpos.x>0)
                    o.col=fixed4(_Time.x,_Time.y,_Time.z,1);
                else
                    o.col=fixed4(_SinTime.x,_CosTime.y,_SinTime.y*_CosTime.x,1);

                return o;
            }

            fixed4 frag(v2f IN):COLOR
            {
                return IN.col;
            }


            ENDCG            
        }
    }
}
