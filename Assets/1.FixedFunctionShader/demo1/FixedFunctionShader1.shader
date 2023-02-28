Shader "Learning/1.FixedFunction/FixedFunctionShader1"//定义Shader名称，按照集联菜单形式编写
{
    Properties{
        _Color("Main Color",color)=(1,1,1,1)
        _Ambient("Ambient",color)=(0.3,0.3,0.3,1)
        _Specular("Specular",color)=(1,1,1,1)
        _Shininess("Shininess",range(0,8))=4
        _Emission("Emission",color)=(1,1,1,1)
    }
    SubShader
    {
        pass
        {
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
        }
    }
}
