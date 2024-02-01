/// @description Draw UI
draw_set_color(c_white);
draw_rectangle(0, room_height - 128, room_width, room_height, false);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_text(0, room_height - 156, "Reserves:");

if (selected_swap_daemon != noone)
{
    draw_sprite_ext(sTarget, 0, selected_swap_daemon.x, selected_swap_daemon.y, 1 + 0.25*sin(current_time/500), 1 + 0.25*sin(current_time/500), target_theta, c_white, 1);
}