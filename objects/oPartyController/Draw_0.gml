/// @description Draw UI
if (selected_swap_daemon != noone)
{
    draw_sprite_ext(sTarget, 0, selected_swap_daemon.x, selected_swap_daemon.y, 1 + 0.25*sin(current_time/500), 1 + 0.25*sin(current_time/500), target_theta, c_white, 1);
}