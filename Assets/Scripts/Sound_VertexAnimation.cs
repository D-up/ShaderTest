using UnityEngine;
using System.Collections;

public class Sound_VertexAnimation : MonoBehaviour {

    public AudioSource ASource;
    public Material mMaterial;
    // Use this for initialization
    float[] SoundData;

	//void Start () {
 //       if (mMaterial == null)
 //           mMaterial = this.GetComponent<Material>();

 //       if (ASource == null)
 //           ASource = this.GetComponent<AudioSource>();
       
 //   }
	
	//// Update is called once per frame
	//void Update () {
 //       SoundData = ASource.GetSpectrumData(128, 0, FFTWindow.Blackman);
 //       //Debug.Log(SoundData[0]+"---"+ SoundData[1]+"---"+ SoundData[2]);

 //       if (ASource.clip != null && ASource.isPlaying)
 //       {    
 //           mMaterial.SetFloat("_SoundAngular", (SoundData[0]+ SoundData[1]+ SoundData[2]+ SoundData[3]+ SoundData[4]+ SoundData[5])*5);
 //       }
       
 //   }
}
