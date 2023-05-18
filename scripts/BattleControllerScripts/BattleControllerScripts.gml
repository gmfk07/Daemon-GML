function clear_selected_daemon()
{
	if (selected_daemon != noone)
	{
		selected_daemon.selected = false;
		selected_daemon.image_xscale /= SELECTED_IMAGE_SCALE;
		selected_daemon.image_yscale /= SELECTED_IMAGE_SCALE;
	
		selected_daemon = noone;

		for (var i = 0; i < ds_list_size(move_card_list); i++)
		{
			instance_destroy(ds_list_find_value(move_card_list, i));
		}
		ds_list_clear(move_card_list);
	
		selected_targets = [];
		selected_card = noone;
		selected_move_index = -1;
	}
}

function start_new_turn()
{
	with (player_top_battle_daemon) { event_user(0); }
	with (player_center_battle_daemon) { event_user(0); }
	with (player_bottom_battle_daemon) { event_user(0); }
}