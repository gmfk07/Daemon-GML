/// @description Handle updating daemons, going back to overworld
if (selected_party_daemon != noone)
{
    var max_swap_select_distance = 300;
    closest_daemon_position = max_swap_select_distance;
    closest_daemon = noone;
    
    with (oPartyDaemon)
    {
        if (self != other.selected_party_daemon && point_distance(x, y, mouse_x, mouse_y) <= other.closest_daemon_position)
        {
            other.closest_daemon = self;
            other.closest_daemon_position = point_distance(x, y, mouse_x, mouse_y);
        }
    }
    
    selected_swap_daemon = closest_daemon;
}

target_theta = (target_theta - 1) mod 360;

if (keyboard_check_pressed(vk_tab))
{
    room_goto(global.data_controller.last_overworld_room);
	if (global.data_controller.selecting_starters)
	{
		clear_reserves();
		goto_next_scene();
	}
}