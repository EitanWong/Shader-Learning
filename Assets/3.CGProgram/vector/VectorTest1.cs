using UnityEngine;

[ExecuteInEditMode]
public class VectorTest1 : MonoBehaviour
{
    MeshRenderer _renderer;
    MeshFilter _filter;
    Mesh _mesh;
    void Awake()
    {
        if (!TryGetComponent(out _renderer))
            _renderer = gameObject.AddComponent<MeshRenderer>();
        if (!TryGetComponent(out _filter))
            _filter = gameObject.AddComponent<MeshFilter>();
        
    }
    
    [ContextMenu("Generate")]
    private void Generate()
    {
        GenerateTriangle();
        _renderer.sharedMaterial = new Material(Shader.Find("Standard"));
        _filter.sharedMesh = _mesh;
    }

    private void GenerateTriangle()
    {
        _mesh = new Mesh();
        Vector3[] vertices = new Vector3[3];
        vertices[0] = new Vector3(0, 1, 0);
        vertices[1] = new Vector3(1, -1, 0);
        vertices[2] = new Vector3(-1, -1, 0);
        _mesh.vertices = vertices;
        _mesh.triangles = new[]
        {
            0,1,2//遍历的顺序会影响三角面的朝向 
        };

        Vector3[] normals = new Vector3[3];

        var V_BA = GetDir(vertices[1], vertices[0]);
        var V_CA = GetDir(vertices[2], vertices[0]);
        normals[0] = Vector3.Cross(V_BA, V_CA);

        var V_CB = GetDir(vertices[2], vertices[1]);
        var V_AB = GetDir(vertices[0], vertices[1]);

        normals[1] = Vector3.Cross(V_CB, V_AB);
        
        var V_AC = GetDir(vertices[0], vertices[2]);
        var V_BC = GetDir(vertices[1], vertices[2]);
        
        normals[2] = Vector3.Cross(V_AC, V_BC);

        _mesh.normals = normals;
    }

    private Vector3 GetDir(Vector3 v1, Vector3 v2)
    {
        return v1 - v2;
    }
}
