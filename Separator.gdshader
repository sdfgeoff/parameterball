shader_type canvas_item;

void fragment() {
	float dashes = step(0.5, mod(SCREEN_UV.y * 100.0, 1.0));
	COLOR = vec4(dashes);
}
