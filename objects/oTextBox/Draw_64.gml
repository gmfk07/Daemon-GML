/// @description Draw
draw_sprite_stretched(sprite_index, 0, x, y, width, height);

// Text
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_dialogue);
draw_set_color(text_color);
type(x + text_x, y + text_y, text, text_index, text_width);

// Options
if (finished && option_count > 0) {
	draw_set_valign(fa_middle);
	draw_set_color(option_text_color);
	for (var i = 0; i < option_count; i++) {
		var opt_x = x + option_x;
		var opt_y = y + option_y - (option_count - i - 1) * option_spacing;
		
		// Selected option is indented with an arrow
		if (i == current_option) {
			opt_x += option_selection_indent;
			draw_sprite(sMenuboxArrow, 0, opt_x, opt_y);
		}
		
		draw_sprite_stretched(sMenuBox, 0, opt_x, opt_y - option_height / 2, option_width, option_height);
		draw_text(opt_x + option_text_x, opt_y, options[i].text);
	}
}