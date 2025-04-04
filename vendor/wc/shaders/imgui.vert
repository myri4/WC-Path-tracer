#pragma shader_stage(vertex)

#extension GL_EXT_buffer_reference : require
#extension GL_EXT_scalar_block_layout : enable

struct Vertex 
{
	vec2 pos;
    vec2 uv;
    uint color;
};

layout(buffer_reference, scalar) buffer VertexBufferPointer { Vertex vertices[]; };

layout(push_constant) uniform PushConstant
{ 
    vec2 scale; 
    vec2 translate;
    VertexBufferPointer vbp;
};

layout(location = 0) out vec4 Color;
layout(location = 1) out vec2 uv;

vec4 decompress(const in uint num) 
{ // Remember! Convert from 0-255 to 0-1!
    vec4 Output;
    Output.r = float((num & uint(0x000000ff)));
    Output.g = float((num & uint(0x0000ff00)) >> 8);
    Output.b = float((num & uint(0x00ff0000)) >> 16);
    Output.a = float((num & uint(0xff000000)) >> 24);
    return Output;
}

void main()
{
    Vertex vertex = vbp.vertices[gl_VertexIndex];

    Color = decompress(vertex.color) / 255.f;
    uv = vertex.uv;
    gl_Position = vec4(vertex.pos * scale + translate, 0, 1);
}