/// @description Display dialogue box
if (in_dialogue)
{
	draw_set_color(c_gray);
	draw_rectangle(view_get_xport(0) + 32, view_get_yport(0) + view_get_hport(0) - 128, view_get_xport(0) + view_get_wport(0) - 32, view_get_yport(0) + view_get_hport(0) - 32, false);
	draw_set_color(c_black);
	draw_set_font(fnt_dialogue);
	draw_set_halign(fa_left);
	draw_text_ext(view_get_xport(0) + 48, view_get_yport(0) + view_get_hport(0) - 112, dialogue[dialogue_index], 16, view_get_wport(0) - 64);
}