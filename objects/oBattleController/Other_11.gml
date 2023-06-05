/// @description Handle card released
points -= selected_card.move.cost;

with (selected_daemon)
{
	selected_targets = other.selected_targets;
	selected_move = other.selected_card.move;
		
	if (selected_targets == [])
	{
		//No selected targets
		image_blend = c_white;
	}
	else
	{
		image_blend = c_dkgray;
	}
}

selected_card = noone;

clear_selected_daemon(false);