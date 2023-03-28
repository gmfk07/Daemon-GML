/// @description Trigger selecting daemon
with (instance_find(oBattleController, 0))
{
	if (phase = battle_phases.selecting)
	{
		if (selected_daemon != noone)
		{
			selected_daemon.selected = false;
			selected_daemon.image_xscale = 1;
			selected_daemon.image_yscale = 1;
		}
		selected_daemon = other;
		other.selected = true;
		other.image_xscale = 1.3;
		other.image_yscale = 1.3;
	}
}