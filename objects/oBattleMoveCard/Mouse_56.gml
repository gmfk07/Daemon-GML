/// @description Stop selecting card
if (selected)
{
	selected = false;

	x = source_x;
	y = source_y;
	
	layer = layer_get_id("Cards");
	
	with (global.battle_controller)
	{
		event_user(1);
	}
}