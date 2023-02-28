
struct appdata_base
{
    float2 pos:POSITION;
    float4 col:COLOR;
};


float Func2(float arr[3])
{
    float sum=0;
    for (int i=0;i<arr.Length;i++)
    {
        sum+=arr[i];
    }
    return sum;
}

void Func(out fixed4 c)
{
    c=fixed4(0,1,0,1);
}