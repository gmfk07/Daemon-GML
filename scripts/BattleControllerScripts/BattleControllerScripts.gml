function clear_selected_daemon(clear_move)
{
	if (selected_daemon != noone)
	{
		selected_daemon.selected = false;
		
		if (clear_move)
		{
			if (selected_daemon.selected_move != noone)
			{
				points += selected_daemon.selected_move.cost;
			}
			
			selected_daemon.selected_move = noone;
			selected_daemon.selected_targets = [];
		}
		
		selected_daemon.image_xscale /= SELECTED_IMAGE_SCALE;
		selected_daemon.image_yscale /= SELECTED_IMAGE_SCALE;
	
		selected_daemon = noone;
		selected_targets = noone;

		for (var i = 0; i < ds_list_size(move_card_list); i++)
		{
			instance_destroy(ds_list_find_value(move_card_list, i));
		}
		ds_list_clear(move_card_list);
	}
}

function start_new_turn()
{
	with (ds_map_find_value(position_daemon_map, positions.player_top)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.player_center)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.player_bottom)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.enemy_top)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.enemy_center)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.enemy_bottom)) { event_user(0); }
	
	phase = battle_phases.selecting;
	points = max_points;
	var battle_daemon_array = get_all_battle_daemon();
	
	for (var i=0; i < array_length(battle_daemon_array); i++)
	{
		battle_daemon_array[i].attacked = false;
	}
}

function get_all_battle_daemon()
{
	var enemy_top_battle_daemon = ds_map_find_value(position_daemon_map, positions.enemy_top);
	var enemy_center_battle_daemon = ds_map_find_value(position_daemon_map, positions.enemy_center);
	var enemy_bottom_battle_daemon = ds_map_find_value(position_daemon_map, positions.enemy_bottom);
	
	var player_top_battle_daemon = ds_map_find_value(position_daemon_map, positions.player_top);
	var player_center_battle_daemon = ds_map_find_value(position_daemon_map, positions.player_center);
	var player_bottom_battle_daemon = ds_map_find_value(position_daemon_map, positions.player_bottom);
	
	return [enemy_top_battle_daemon, enemy_center_battle_daemon, enemy_bottom_battle_daemon, player_top_battle_daemon, player_center_battle_daemon, player_bottom_battle_daemon];
}

function get_possible_target_positions(user_position, targets)
{
	switch (targets)
	{
		case targets.single_enemy:
			switch (user_position)
			{
				case positions.player_top:
					return [positions.enemy_top, positions.enemy_center];
				break;
				
				case positions.player_center:
					return [positions.enemy_top, positions.enemy_center, positions.enemy_bottom];
				break;
				
				case positions.player_bottom:
					return [positions.enemy_center, positions.enemy_bottom];
				break;
				
				case positions.enemy_top:
					return [positions.player_top, positions.player_center];
				break;
				
				case positions.enemy_center:
					return [positions.player_top, positions.player_center, positions.player_bottom];
				break;
				
				case positions.enemy_bottom:
					return [positions.player_center, positions.player_bottom];
				break;
			
				default:
					show_message("uh oh! invalid target");
				break;
			}
		break;
			
		case targets.single_ally_self_inclusive:
			switch (user_position)
			{
				case positions.player_top:
					return [positions.player_center, selected_daemon.position];
				break;
				
				case positions.player_center:
					return [positions.player_top, positions.player_bottom, selected_daemon.position];
				break;
				
				case positions.player_bottom:
					return [positions.player_center, selected_daemon.position];
				break;
				
				case positions.enemy_top:
					return [positions.enemy_center, selected_daemon.position];
				break;
				
				case positions.enemy_center:
					return [positions.enemy_top, positions.enemy_bottom, selected_daemon.position];
				break;
				
				case positions.enemy_bottom:
					return [positions.enemy_center, selected_daemon.position];
				break;
			
				default:
					show_message("uh oh! invalid target");
				break;
			}
		break;
			
		case targets.single_ally_self_exclusive:
			switch (user_position)
			{
				case positions.player_top:
					return [positions.player_center];
				break;
				
				case positions.player_center:
					return [positions.player_top, positions.player_bottom];
				break;
				
				case positions.player_bottom:
					return [positions.player_center];
				break;
				
				case positions.enemy_top:
					return [positions.enemy_center];
				break;
				
				case positions.enemy_center:
					return [positions.enemy_top, positions.enemy_bottom];
				break;
				
				case positions.enemy_bottom:
					return [positions.enemy_center];
				break;
			
				default:
					show_message("uh oh! invalid target");
				break;
			}
		break;
	}
}

function take_enemy_turn()
{
	var enemy_points = max_points;
	var user_position_order = array_shuffle([positions.enemy_top, positions.enemy_center, positions.enemy_bottom]);
	
	for (var i=0; i < array_length(user_position_order); i++)
	{
		var selected_battle_daemon = ds_map_find_value(position_daemon_map, user_position_order[i]);
		var selected_move_index = -1;
		
		for (var j=0; j < ds_list_size(selected_battle_daemon.hand_list); j++)
		{
			var cost = ds_list_find_value(selected_battle_daemon.hand_list, j).cost;
			if (enemy_points - cost >= 0)
			{
				selected_move_index = j;
				enemy_points -= cost;
				break;
			}
		}
		
		if (selected_move_index == -1)
		{
			continue;
		}
		
		selected_battle_daemon.selected_move = ds_list_find_value(selected_battle_daemon.hand_list, selected_move_index);
		var target_position_order = array_shuffle(get_possible_target_positions(user_position_order[i], ds_list_find_value(selected_battle_daemon.hand_list, selected_move_index).targets));
		selected_battle_daemon.selected_targets = [target_position_order[0]];
	}
}

//Returns an array of length equal to target_daemon_array with the damage that each daemon will take
function calculate_total_move_damage(move, using_daemon, target_daemon_position_array)
{
	var result = [];
	
	for (var i=0; i<array_length(target_daemon_position_array); i++)
	{
		var target_daemon = ds_map_find_value(position_daemon_map, target_daemon_position_array[i]);
		var damage = 0;
		
		for (var j=0; j<array_length(move.effects); j++)
		{
			if (move.effects[j][0] == effects.physical_damage)
			{
				damage += move.effects[j][1] + using_daemon.physical_attack;
				for (var k=0; k < array_length(target_daemon.classes); k++)
				{
					if (array_contains(get_class_weaknesses(target_daemon.classes[k]), move.class))
					{
						damage *= ATTACK_OUTCLASS_DAMAGE_MULTIPLIER;
					}
					if (array_contains(get_class_strengths(target_daemon.classes[k]), move.class))
					{
						damage *= DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER;
					}
				}
			}
			else if (move.effects[j][0] == effects.energy_damage)
			{
				damage += move.effects[j][1] + using_daemon.energy_attack;
				for (var k=0; k < array_length(target_daemon.classes); k++)
				{
					if (array_contains(get_class_weaknesses(target_daemon.classes[k]), move.class))
					{
						damage *= ATTACK_OUTCLASS_DAMAGE_MULTIPLIER;
					}
					if (array_contains(get_class_strengths(target_daemon.classes[k]), move.class))
					{
						damage *= DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER;
					}
				}
			}
		}
		
		array_push(result, damage);
	}
	
	return result;
}