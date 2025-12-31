shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_disabled,diffuse_toon,specular_toon;

uniform vec4 albedo : source_color;
uniform sampler2D color_gradient;
uniform sampler2D depth_gradient;
uniform sampler2D fresnel_gradient;
uniform sampler2D diffuse_texture : source_color;
uniform sampler2D dither_texture : source_color;

float fresnel(float amount, vec3 normal, vec3 view)
{
    return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0)), amount);
}

void vertex(){
    
}

void fragment(){
    vec3 diffusetex_color = texture(diffuse_texture, UV).rgb;
    float depth = clamp(-VERTEX.z / 10.0, 0.0, 1.0);
    float basic_fresnel = fresnel(4, NORMAL, VIEW);
    //ALBEDO = vec3(depth);//(diffusetex_color); //+ (basic_fresnel + texture(fresnel_gradient, vec2(basic_fresnel, 0.0)).rgb + 1.0);
    vec3 dither_mask = texture(dither_texture, SCREEN_UV * VIEWPORT_SIZE / 5.0).rgb;
    vec3 depth_layer = (texture(depth_gradient, vec2(depth, 0.0)).rgb);
    vec3 dither_plus_diffuse = depth_layer * diffusetex_color * mix(depth_layer,diffusetex_color, 1.0 - dither_mask);//diffusetex_color * dither_mask + depth_layer * (1.0 - dither_mask);
    vec3 fresnel_layer = texture(fresnel_gradient, vec2(basic_fresnel, 0.0)).rgb;
    
    ALBEDO = 1.0 - (1.0 - dither_plus_diffuse) * (1.0 - fresnel_layer);
}

void light() {
    float dotproduct = clamp(dot(NORMAL, LIGHT), -0.9, 0.9);
    float sample = clamp((dotproduct + 1.0) + ATTENUATION / 2.1, 0.05, 0.95);
    vec4 shaded = texture(color_gradient, vec2(sample, 0.0));
    
    vec3 dither_mask = texture(dither_texture, SCREEN_UV * VIEWPORT_SIZE / 5.0).rgb;
    vec3 lighting = clamp((shaded.rgb * LIGHT_COLOR * sample), 0.0, 1.0);
    DIFFUSE_LIGHT += clamp((shaded.rgb * LIGHT_COLOR * sample), 0.0, 1.0);
    //DIFFUSE_LIGHT += mix(DIFFUSE_LIGHT, dither_mask, lighting);
    
}