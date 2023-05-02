/// @description Stop selecting card
if (selected)
{
	selected = false;
	global.battle_controller.selected_card = noone;
	global.battle_controller.selected_move_index = -1;
	global.battle_controller.selected_targets = []
	
	x = original_x;
	y = original_y;
	
	layer = layer_get_id("Cards");
}