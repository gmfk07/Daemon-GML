/// @description Start selecting card
if (!selected && global.battle_controller.phase == battle_phases.selecting && global.battle_controller.selected_card == noone && global.battle_controller.points >= move.cost + (same_class ? 0 : 1))
{
	selected = true;
	global.battle_controller.selected_card = self;
	
	layer = layer_get_id("UI");
}