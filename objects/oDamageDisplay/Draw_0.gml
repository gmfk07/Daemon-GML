/// @description Draw damage text
if (amount > 0)
{
	draw_set_color(c_green);
}
else
{
	draw_set_color(c_red);
}
draw_set_alpha(1 - seconds_alive/target_seconds_alive);
draw_set_font(fnt_damage);
draw_text(x, y + (y_offset_per_second * seconds_alive), string(amount));