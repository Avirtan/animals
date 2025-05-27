#version 140

//константы
// uniform fs_uniforms {
    // mediump vec4 tint;
// };

// из фрагментного
in vec2 var_texcoord0;
in vec4 var_tint;
in vec4 var_position;
in float var_colored_percent;

//текстура
uniform sampler2D texture_sampler;

//итогоый цвет
out vec4 out_fragColor;

void main() {
    vec4 tint_pm = vec4(var_tint.xyz * var_tint.w, var_tint.w);
    vec4 color_texture = texture(texture_sampler, var_texcoord0.xy);
    if(var_position.y > var_colored_percent) {
        out_fragColor = color_texture;
    } else {
        out_fragColor = color_texture * tint_pm;
    }

}
