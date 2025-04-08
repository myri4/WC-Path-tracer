#pragma shader_stage(fragment)

layout(location = 0) in vec4 v_Color;
layout(location = 1) in flat ivec2 v_EntityID;

layout(location = 0) out vec4 FragColor;
layout(location = 1) out ivec2 EntityID;

void main() 
{
    FragColor = v_Color;
    EntityID = v_EntityID;
}