/// @description Start selecting card
if (!selected && global.battle_controller.selected_card == noone && global.battle_controller.points >= move.cost)
{
	selected = true;
	global.battle_controller.selected_card = self;
	
	layer = layer_get_id("UI");
}