/// @description If card being held, check for targets + target rotate
if (selected_card != noone)
{
	var move_data = selected_card.move;
	var possible_targets = [];
	var max_target_select_distance = 200;
	
	if (move_data.targets == targets.single_enemy)
	{
		var possible_targets;
		switch (selected_daemon)
		{
			case player_top_battle_daemon:
				possible_targets = [enemy_top_battle_daemon, enemy_center_battle_daemon];
			break;
				
			case player_center_battle_daemon:
				possible_targets = [enemy_top_battle_daemon, enemy_center_battle_daemon, enemy_bottom_battle_daemon];
			break;
				
			case player_bottom_battle_daemon:
				possible_targets = [enemy_center_battle_daemon, enemy_bottom_battle_daemon];
			break;
			
			default:
				show_message("uh oh!");
			break;
		}
		
		var closest_target_dist = max_target_select_distance;
		var closest_target = noone;
		for (var i=0; i < array_length(possible_targets); i++)
		{
			var target = possible_targets[i];
			var dist = point_distance(mouse_x, mouse_y, target.x, target.y);
			if (dist < closest_target_dist)
			{
				closest_target_dist = dist;
				closest_target = target;
			}
		}
		
		if (closest_target == noone)
		{
			selected_targets = [];
		}
		else
		{
			selected_targets = [closest_target];
		}
	}
}

target_theta = (target_theta - 1) mod 360;