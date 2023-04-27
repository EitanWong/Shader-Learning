using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VoiceControl : MonoBehaviour
{

[SerializeField] float multiplyer=10;
    AudioClip clip;
    string device=null;

    Material mat;
    // Start is called before the first frame update
    void Start()
    {
        device= Microphone.devices[0];
        clip=Microphone.Start(device,true,999,44100);
        mat=GetComponent<Renderer>().sharedMaterial;
        
    }

    private void Update() {
        var volume= GetVolume();

        mat.SetFloat("_Height",volume*multiplyer);
        //Debug.Log(volume);
    }


    public float GetVolume()
    {
        if(Microphone.IsRecording(device))
        {
            int sampleSize=128;
            float[] samples=new float[sampleSize];
            int startPosition= Microphone.GetPosition(device)-(sampleSize+1);
            clip.GetData(samples,startPosition);
            float levelMax=0;
            for (int i = 0; i < sampleSize; i++)
            {
                float wavePeak=samples[i];
                if(levelMax<wavePeak)
                {
                    levelMax=wavePeak;
                }
            }
            return levelMax;
        }
        return 0;
    }


}
