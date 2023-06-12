/// @description Handle card released
if (!array_equals(selected_targets, []))
{
	points -= selected_card.move.cost;
}

with (selected_daemon)
{
	selected_targets = other.selected_targets;
		
	if (array_equals(selected_targets, []))
	{
		//Invalid selected targets
		image_blend = c_white;
		selected_move = noone;
	}
	else
	{
		image_blend = c_dkgray;
		selected_move = other.selected_card.move;
	}
}

selected_card = noone;

clear_selected_daemon(false);