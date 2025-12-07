#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pix = texture(tex, v_texcoord);
    float r = pix.r;
    float g = pix.g;
    float b = pix.b;

    fragColor = vec4(r * 0.7 + b * 0.3, g * 0.7, 0.0, pix.a);
}
