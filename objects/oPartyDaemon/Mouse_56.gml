/// @description Stop selecting card
if (selected)
{
	with (global.party_controller)
	{
		event_user(0);
	}
	
	selected = false;
	global.party_controller.selected_party_daemon = noone;

	x = source_x;
	y = source_y;
	
	layer = layer_get_id("Interactables");
}