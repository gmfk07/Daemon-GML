/// @description Trigger selecting daemon
if (!selected && player_owned)
{
	selected = true;
	image_xscale *= SELECTED_IMAGE_SCALE;
	image_yscale *= SELECTED_IMAGE_SCALE;
		
	with (global.battle_controller)
	{
		if (phase == battle_phases.selecting)
		{
			if (selected_daemon != noone)
			{
				selected_daemon.selected = false;
				selected_daemon.image_xscale /= SELECTED_IMAGE_SCALE;
				selected_daemon.image_yscale /= SELECTED_IMAGE_SCALE;
			}
			selected_daemon = other;
		}
	
		event_user(0);
	}
}