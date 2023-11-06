/// @description Handle updating cards and battle phases
if (phase == battle_phases.prep || phase == battle_phases.action || phase == battle_phases.move)
{
	if (num_ongoing_animations == 0)
	{
		var potential_actors = get_all_battle_daemon();
		var next_actor = try_get_next_acting_battle_daemon(potential_actors, phase);
	
		if (next_actor != noone)
		{
			if (instance_number(oMoveCard) == 0 || !instance_find(oMoveCard, 0).is_moused_over)
			{
				if (move_animation_card != noone)
				{
					with (move_animation_card)
					{
						instance_destroy();
					}
					move_animation_card = noone;
				}
				battle_daemon_animate_move(next_actor);
			}
		}
		else
		{
			switch (phase)
			{
				case battle_phases.prep:
				{
					phase = battle_phases.action;
					break;
				}
				case battle_phases.action:
				{
					phase = battle_phases.move;
					break;
				}
				case battle_phases.move:
				{
					start_new_turn();
					break;
				}
			}
		}
	}
}
else if (phase == battle_phases.selecting)
{
	// If card being held, check for targets + target rotate
	if (selected_card != noone)
	{
		var move_data = selected_card.move;
		var possible_targets = [];
		var max_target_select_distance = 300;
		
		var player_top_battle_daemon = ds_map_find_value(position_daemon_map, positions.player_top);
		var player_center_battle_daemon = ds_map_find_value(position_daemon_map, positions.player_center);
		var player_bottom_battle_daemon = ds_map_find_value(position_daemon_map, positions.player_bottom);
		
		var enemy_top_battle_daemon = ds_map_find_value(position_daemon_map, positions.enemy_top);
		var enemy_center_battle_daemon = ds_map_find_value(position_daemon_map, positions.enemy_center);
		var enemy_bottom_battle_daemon = ds_map_find_value(position_daemon_map, positions.enemy_bottom);
	
		if (move_data.can_target_dead)
		{
			possible_targets = get_possible_target_positions(selected_daemon.position, selected_card.move.targets);
		}
		else
		{
			possible_targets = get_possible_living_target_positions(selected_daemon.position, selected_card.move.targets);
		}
		
		var closest_target_dist = max_target_select_distance;
		var closest_target = noone;
		for (var i=0; i < array_length(possible_targets); i++)
		{
			var target = ds_map_find_value(position_daemon_map, possible_targets[i]);
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
			selected_targets = [closest_target.position];
		}
	}

	target_theta = (target_theta - 1) mod 360;
}

if (keyboard_check_pressed(ord("B")))
{
	room_goto(rOverworld);
}