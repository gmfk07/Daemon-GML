/// @description Stop selecting card
if (selected)
{
	selected = false;

	x = original_x;
	y = original_y;
	
	layer = layer_get_id("Cards");
	
	selected_card = noone;
	with (global.battle_controller)
	{
		event_user(1);
	}
}