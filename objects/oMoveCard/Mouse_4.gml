/// @description Start selecting card
if (!selected && global.battle_controller.selected_card == noone)
{
	selected = true;
	global.battle_controller.selected_card = self;
	global.battle_controller.selected_move_index = move_index;
	
	original_x = x;
	original_y = y;
	
	layer = layer_get_id("UI");
}