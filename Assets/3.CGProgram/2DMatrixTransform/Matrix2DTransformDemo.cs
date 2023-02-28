using UnityEngine;

public class Matrix2DTransformDemo : MonoBehaviour
{
    MeshRenderer _renderer;
    MeshFilter _filter;
    Mesh _mesh;

    void Awake()
    {
        if (!TryGetComponent(out _renderer))
        {
            _renderer = gameObject.AddComponent<MeshRenderer>();
            _renderer.sharedMaterial = new Material(Shader.Find("Standard"));
        }
        if (!TryGetComponent(out _filter))
        {
            _filter = gameObject.AddComponent<MeshFilter>();
            _mesh = GenerateTriangleMesh();
            _filter.sharedMesh = _mesh;
        }
    }
    void FixedUpdate()
    {
        Rotate(_mesh,1);
    }

    private Mesh GenerateTriangleMesh()
    {
        Mesh mesh = new Mesh();
        mesh.vertices = new[]
        {
            new Vector3(0, 0.25f, 0),//0
            new Vector3(0.25f, -0.25f, 0),//1
            new Vector3(-0.25f, -0.25f, 0),//2
        };
        mesh.triangles = new[]
            {0,1,2};
        mesh.RecalculateNormals();
        return mesh;
    }

    private void Rotate(Mesh mesh,int degree)
    {
        float angle = degree * Mathf.PI/180;
        Vector3[] vertices = mesh.vertices;
        for (int i = 0; i < vertices.Length; i++)
        {
            vertices[i]=TransformVertex(vertices[i],angle);
        }
        mesh.SetVertices(vertices);
        mesh.RecalculateNormals();
    }
    private Vector3 TransformVertex(Vector3 vertex,float angle)
    {
        var newX = vertex.x * Mathf.Cos(angle) - vertex.y * Mathf.Sin(angle);
        var newY = vertex.x * Mathf.Sin(angle) + vertex.y * Mathf.Cos(angle);
        vertex.Set(newX,newY,vertex.z);
        return vertex;
    }
}
