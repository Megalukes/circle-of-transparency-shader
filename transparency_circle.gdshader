shader_type spatial;
render_mode blend_mix;

uniform vec2 player_screen_pos;
uniform vec3 player_position;
uniform vec3 camera_forward;

uniform vec2 position_adjustment = vec2(0.0);
uniform float radius : hint_range(0.0, 0.5) = 0.1;
uniform float smoothness : hint_range(0.0, 0.2) = 0.05;

void fragment() {
    float aspect_ratio = VIEWPORT_SIZE.x / VIEWPORT_SIZE.y;
    vec2 correction = vec2(aspect_ratio, 1.0);
    vec2 screen_uv = FRAGCOORD.xy / VIEWPORT_SIZE.xy;
    float dist = length((screen_uv - player_screen_pos + position_adjustment) * correction);
    float outside_circle = smoothstep(radius - smoothness, radius, dist);
	vec3 to_player = normalize(player_position - NODE_POSITION_WORLD);
	float facing = dot(to_player, camera_forward);
	
	if (facing < 0.0)
	{
    	ALPHA = outside_circle;

	}
}