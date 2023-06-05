/// @description Start selecting card
if (!selected && global.battle_controller.selected_card == noone && global.battle_controller.points >= move.cost)
{
	selected = true;
	global.battle_controller.selected_card = self;
	
	original_x = x;
	original_y = y;
	
	layer = layer_get_id("UI");
}