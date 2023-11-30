/// @description Handle updating cards and battle phases
if (phase == battle_phases.prep || phase == battle_phases.action || phase == battle_phases.move)
{
	if (!global.battle_animation_controller.in_animation)
	{
		var potential_actors = get_all_battle_daemon();
		var next_actor = try_get_next_acting_battle_daemon(potential_actors, phase);
		if (next_actor != noone)
		{
			battle_daemon_animate_move(next_actor);
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
	
	//If wild battle, check for displaying catch button
	if (battle_type == battle_types.wild)
	{
		if (selected_daemon == noone && catch_button == noone && get_catchable_daemon_position() != noone)
		{
			catch_button = instance_create_layer(room_width/2, room_height - 128, "UI", oCatch);
		}
		
		if (selected_daemon != noone && catch_button != noone)
		{
			with (catch_button)
			{
				instance_destroy();
			}
			catch_button = noone;
		}
	}

	//Rotate the target icons
	target_theta = (target_theta - 1) mod 360;
}

if (keyboard_check_pressed(ord("B")))
{
	room_goto(rOverworld);
}