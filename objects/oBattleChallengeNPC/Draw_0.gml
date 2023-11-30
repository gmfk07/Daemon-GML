/// @description Draw battle radius
if (!defeated)
{
	draw_set_alpha(0.5);
	draw_set_color(c_black);
	draw_circle(x, y, detection_radius, false);
}
draw_set_alpha(1);
draw_set_color(c_white);
draw_self();