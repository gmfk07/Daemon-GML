/// @description Display hand size requirement
draw_set_font(fnt_damage);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(0, 0, string(array_length(active_moves)) + "/" + string(min_cards));