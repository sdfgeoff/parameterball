shader_type canvas_item;

void fragment() {
	float radius = 1.0 - length(UV - 0.5) * 2.0;
	COLOR = vec4(step(0, radius));
}
