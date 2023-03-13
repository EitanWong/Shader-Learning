using UnityEngine;

[ExecuteInEditMode]
public class Uniform : MonoBehaviour
{
    [SerializeField] Color secondColor;
    
    private void Update() {
        GetComponent<Renderer>().material.SetVector("_SecondColor", secondColor);
        
    }
}
