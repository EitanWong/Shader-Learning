Shader "ShaderLeaning/VertexOffset/vf1"
{

    Properties{
        
        _Radius("Radius",Range(0,10))=1
        _Height("Height",Range(0,10))=1
        _X("X",float)=1
        _Y("Y",float)=1
    }
    SubShader{

        Pass{
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            float _Radius;
            float _Height;
            float _X;
            float _Y;

            struct v2f
            {
                float4 pos: POSITION;
                fixed4 col: COLOR;
            };

            v2f vert(appdata_base v)
            {
                v2f o;    
                

                // float2 xy=v.vertex.xz;    
                float2 xy=mul(unity_ObjectToWorld,v.vertex).xz;

                float d=_Radius-length(xy-float2(_X,_Y));
                d=d<0?0:d;
                

                float4 newPos=float4(v.vertex.x,_Height*d,v.vertex.z,v.vertex.w);

                o.col=fixed4(newPos.y,newPos.y,newPos.y,1);
                o.pos=UnityObjectToClipPos(newPos);

                
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