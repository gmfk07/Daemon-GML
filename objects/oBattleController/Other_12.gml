/// @description Handle lock in button pressed
if (phase == battle_phases.selecting)
{
	phase = battle_phases.prep;
	
	if (selected_daemon != noone)
	{
		with (selected_daemon)
		{
			selected_targets = other.selected_targets;
		
			image_blend = c_white;
			selected_move = noone;
		}

		selected_card = noone;

		clear_selected_daemon(false);
	}
}