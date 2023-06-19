/// @description Trigger selecting daemon
if (!selected && player_owned && global.battle_controller.phase == battle_phases.selecting)
{
	selected = true;
	image_xscale *= SELECTED_IMAGE_SCALE;
	image_yscale *= SELECTED_IMAGE_SCALE;
	
	image_blend = c_white;
	
	with (global.battle_controller)
	{
		if (selected_daemon != noone)
		{
			clear_selected_daemon(true);
		}

		selected_daemon = other.id;
		if (other.selected_move != noone)
		{
			points += other.selected_move.cost;
		}
			
		other.selected_move = noone;
		other.selected_targets = [];
		
		event_user(0);
	}
}