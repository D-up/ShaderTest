using UnityEngine;
using System.Collections;

public class MartixTestC : MonoBehaviour {

    Renderer rn;
    Vector2 a;
	// Use this for initialization
	void Start () {
        rn = GetComponent<Renderer>();
	}
	
	// Update is called once per frame
	void Update () {
        Matrix4x4 m = new Matrix4x4();
        m[0, 0] = Mathf.Sin(Time.realtimeSinceStartup);
        rn.sharedMaterial.SetMatrix("RM", m);
	}
}
