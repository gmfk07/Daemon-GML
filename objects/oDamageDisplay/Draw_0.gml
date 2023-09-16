/// @description Draw damage text
draw_set_color(c_red);
draw_set_alpha(1 - seconds_alive/target_seconds_alive);
draw_set_font(fnt_damage);
draw_text(x, y + (y_offset_per_second * seconds_alive), "-" + string(damage));