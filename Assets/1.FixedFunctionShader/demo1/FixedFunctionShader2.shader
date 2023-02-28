Shader "Learning/1.FixedFunction/FixedFunctionShader2"
{
    Properties{
        _Color("Main Color",color)=(1,1,1,1)
        _Ambient("Ambient",color)=(0.3,0.3,0.3,1)
        _Specular("Specular",color)=(1,1,1,1)
        _Shininess("Shininess",range(0,8))=4
        _Emission("Emission",color)=(1,1,1,1)
        _Constant("ConstantColor",color)=(1,1,1,0.3)
        _MainTex("MainTex",2D)="white"{}//{texgen objectlinear}
        _SecondTex("SecondTex",2D)="white"{}
    }
    SubShader
    {
        Tags{"Queue" = "Transparent"}
        pass
        {
            Blend SrcAlpha OneMinusSrcAlpha//Alpha混合
            
//            color(1,1,1,1)//设置颜色，按照红绿蓝Alpha    
//            color[_Color]
            material
            {
                diffuse[_Color] //材质漫反射颜色 ,使用Properties上的Color
                ambient[_Ambient] //环境光颜色
                specular[_Specular]//高光颜色
                shininess[_Shininess]//描述高光的平滑强度
                emission[_Emission]//自发光
            }
            lighting on //启用默认光照 有两个选项on或者off
            separatespecular on //镜面高光启用
            
            settexture[_MainTex]//设置材质纹理贴图
            {
                //combine texture//合并纹理
                combine texture * primary double //合并 纹理乘上前面所有计算了顶点光照的颜色，纹理和前面的primary混合
                //double 乘以2倍、quad乘以4倍
            }
            
            settexture[_SecondTex]//设置第二张纹理材质
            {
                //combine texture//合并纹理
                constantColor[_Constant]
                
                combine texture * previous double,texture* constant //合并之前参与顶点光照颜色和第一个混合材质的颜色 previous
                //double 乘以2倍、quad乘以4倍
            }
            
            //显卡有一个最大的混合纹理的上限，混合的数量是有限的
        }
    }
}
