/// @description Display dialogue box
if (in_dialogue)
{
	draw_set_color(c_gray);
	draw_rectangle(32, room_height - 128, room_width - 32, room_height - 32, false);
	draw_set_color(c_black);
	draw_set_font(fnt_dialogue);
	draw_set_halign(fa_left);
	draw_text_ext(48, room_height - 112, dialogue[dialogue_index], 16, room_width - 64);
}