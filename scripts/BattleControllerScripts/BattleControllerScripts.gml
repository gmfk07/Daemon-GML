function clear_selected_daemon(clear_move)
{
	if (selected_daemon != noone)
	{
		selected_daemon.selected = false;
		
		if (clear_move)
		{
			if (selected_daemon.selected_move != noone)
			{
				points += selected_daemon.selected_move.cost;
			}
			
			selected_daemon.selected_move = noone;
			selected_daemon.selected_targets = [];
		}
		
		selected_daemon.image_xscale /= SELECTED_IMAGE_SCALE;
		selected_daemon.image_yscale /= SELECTED_IMAGE_SCALE;
	
		selected_daemon = noone;
		selected_targets = noone;

		for (var i = 0; i < ds_list_size(move_card_list); i++)
		{
			instance_destroy(ds_list_find_value(move_card_list, i));
		}
		ds_list_clear(move_card_list);
	}
}

function start_new_turn()
{
	with (player_top_battle_daemon) { event_user(0); }
	with (player_center_battle_daemon) { event_user(0); }
	with (player_bottom_battle_daemon) { event_user(0); }
	
	phase = battle_phases.selecting;
	points = max_points;
	var battle_daemon_array = get_all_battle_daemon();
	
	for (var i=0; i < array_length(battle_daemon_array); i++)
	{
		battle_daemon_array[i].attacked = false;
	}
}

function get_all_battle_daemon()
{
	return [enemy_top_battle_daemon, enemy_center_battle_daemon, enemy_bottom_battle_daemon, player_top_battle_daemon, player_center_battle_daemon, player_bottom_battle_daemon];
}