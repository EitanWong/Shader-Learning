// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Learning/GeomertricTransformation/vf1"
{
    SubShader
    {
        pass{

            CGPROGRAM

            #pragma vertex vert

            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            uniform float4x4 _MVP;
            // uniform float4x4 _RM;
            // uniform float4x4 _SM;
            // uniform float _Angle;

            struct v2f{
                float4 pos:POSITION;
            };

 
            float4x4 RotateY(float _Angle)
            {
                float4x4 R_M={
                    cos(_Angle),0,sin(_Angle),0,
                    0,1,0,0,
                    -sin(_Angle),0,cos(_Angle),0,
                    0,0,0,1
                };

                return R_M;
            }

            v2f vert(appdata_base v)
            {
                v2f o;
                
                float4 p=mul(RotateY(_Time*10),v.vertex);

                o.pos=UnityObjectToClipPos(p);

                return o;
            }

            fixed4 frag(v2f IN):COLOR
            {
                return fixed4(1,1,1,1);
            }


            ENDCG            
        }
    }
}
