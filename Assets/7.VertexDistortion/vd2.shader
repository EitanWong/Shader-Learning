Shader "ShaderLeaning/VertexDistortion/vf2"
{

    Properties{
        
        
    }
    SubShader{

        Pass{
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            uniform float _Height=1;
            
            struct v2f
            {
                float4 pos: POSITION;
                fixed4 col: COLOR;
            };

            v2f vert(appdata_base v)
            {
                v2f o;    
          
            float angle=length(v.vertex)*_Time.y;


      
            v.vertex.x=v.vertex.x* (sin(angle)/16+1);
            v.vertex.z=v.vertex.z* (cos(angle)/16+1);
            v.vertex.y=v.vertex.y+(sin(angle)*cos(angle))*_Height;
            

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