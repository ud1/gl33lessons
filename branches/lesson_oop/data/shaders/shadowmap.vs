layout(location = VERT_POSITION) in vec3 position;
layout(location = VERT_TEXCOORD) in vec2 texcoord;
layout(location = VERT_NORMAL)   in vec3 normal;

uniform struct Camera
{
	mat4 model;
	mat4 viewProjection;
	mat4 light;
	mat3 normal;
	vec3 position;
} camera;

uniform struct Light
{
	vec4 ambient;
	vec4 diffuse;
	vec4 specular;
	vec4 position;
} light;

out Vertex
{
	vec2 texcoord;
	vec4 smcoord;
	vec3 normal;
	vec3 lightDir;
	vec3 viewDir;
} vertex;

void main(void)
{
	vec4 vertexpos  = camera.model * vec4(position, 1.0);
	vertex.smcoord  = camera.light * vertexpos;
	vertex.texcoord = texcoord;
	vertex.normal   = camera.normal * normal;
	vertex.lightDir = vec3(light.position);
	vertex.viewDir  = camera.position - vec3(vertexpos);
	gl_Position     = camera.viewProjection * vertexpos;
}