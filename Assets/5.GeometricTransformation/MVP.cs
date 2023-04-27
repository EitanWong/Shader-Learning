using UnityEngine;

public class MVP : MonoBehaviour
{

    void Update()
    {
        
        //构建绕Y轴旋转的矩阵
        Matrix4x4 rm=new Matrix4x4();
        rm[0,0]=Mathf.Cos(Time.realtimeSinceStartup);
        rm[0,2]=Mathf.Sin(Time.realtimeSinceStartup);
        rm[1,1]=1;
        rm[2,0]=-Mathf.Sin(Time.realtimeSinceStartup);
        rm[2,2]=Mathf.Cos(Time.realtimeSinceStartup);
        rm[3,3]=1;

        Matrix4x4 sm=new Matrix4x4();
        sm[0,0]=Mathf.Sin(Time.realtimeSinceStartup)/4+0.5f;
        sm[1,1]=Mathf.Cos(Time.realtimeSinceStartup)/8+0.5f;
        sm[2,2]=Mathf.Sin(Time.realtimeSinceStartup)/6+0.5f;
        sm[3,3]=1;

    
        Matrix4x4 mvp=Camera.main.projectionMatrix*Camera.main.worldToCameraMatrix*transform.localToWorldMatrix;
        
        GetComponent<Renderer>().sharedMaterial.SetMatrix("_MVP",mvp);
        GetComponent<Renderer>().sharedMaterial.SetMatrix("_RM",rm);//传入着色器
        GetComponent<Renderer>().sharedMaterial.SetMatrix("_SM",sm);//传入着色器
    }
}
