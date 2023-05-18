/// @description Trigger selecting daemon
if (!selected && player_owned)
{
	selected = true;
	image_xscale *= SELECTED_IMAGE_SCALE;
	image_yscale *= SELECTED_IMAGE_SCALE;
	
	selected_targets = [];
	image_blend = c_white;
	
	with (global.battle_controller)
	{
		event_user(0);
	}
}