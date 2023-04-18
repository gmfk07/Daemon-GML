/// @description Stop selecting card
if (selected)
{
	selected = false;
	global.battle_controller.selected_card = noone;
	
	x = original_x;
	y = original_y;
	
	layer = layer_get_id("Cards");
}