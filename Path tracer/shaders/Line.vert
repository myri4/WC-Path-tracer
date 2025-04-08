#pragma shader_stage(vertex)

#extension GL_EXT_buffer_reference : require
#extension GL_EXT_scalar_block_layout : enable

struct Vertex
{
	vec3 Position;
	vec4 Color;
	ivec2 EntityID;
};

layout(buffer_reference, scalar) buffer VertexBufferPointer { Vertex vertices[]; };

layout (push_constant) uniform Data
{
	mat4 ViewProj;
    VertexBufferPointer vbp;
};

layout(location = 0) out vec4 v_Color;
layout(location = 1) out flat ivec2 v_EntityID;

void main()
{
    Vertex vertex = vbp.vertices[gl_VertexIndex];
	v_Color = vertex.Color;
	v_EntityID = vertex.EntityID;

    gl_Position = ViewProj * vec4(vertex.Position, 1.f);
}
