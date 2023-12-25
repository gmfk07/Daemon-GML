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
	if (is_defeat())
	{
		global.data_controller.overworld_flag = overworld_flags.defeat;
		room_goto_previous();
	}
	//Hold down K when entering battle for insta-win
	else if (is_victory() || keyboard_check(ord("K")))
	{
		global.data_controller.overworld_flag = overworld_flags.victory;
		handle_experience_gain(1);
		room_goto_previous();
	}
	
	if (move_animation_card != noone)
	{
		with (move_animation_card)
		{
			instance_destroy();
		}
		move_animation_card = noone;
	}
	
	with (ds_map_find_value(position_daemon_map, positions.player_top)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.player_center)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.player_bottom)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.enemy_top)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.enemy_center)) { event_user(0); }
	with (ds_map_find_value(position_daemon_map, positions.enemy_bottom)) { event_user(0); }
	
	phase = battle_phases.selecting;
	max_points++;
	points = max_points;
	var battle_daemon_array = get_all_battle_daemon();
	
	for (var i=0; i < array_length(battle_daemon_array); i++)
	{
		battle_daemon_array[i].attacked = false;
	}
}

function is_defeat()
{
	var top_alive = position_daemon_map[? positions.player_top].hp > 0;
	var center_alive = position_daemon_map[? positions.player_center].hp > 0;
	var bottom_alive = position_daemon_map[? positions.player_bottom].hp > 0;
	
	return !(top_alive || center_alive || bottom_alive);
}

function is_victory()
{
	var top_alive = position_daemon_map[? positions.enemy_top].hp > 0;
	var center_alive = position_daemon_map[? positions.enemy_center].hp > 0;
	var bottom_alive = position_daemon_map[? positions.enemy_bottom].hp > 0;
	
	return !(top_alive || center_alive || bottom_alive);
}

//Returns the position of the only alive enemy daemon, or noone if that condition are not met
function get_catchable_daemon_position()
{
	var top_daemon = position_daemon_map[? positions.enemy_top];
	var center_daemon = position_daemon_map[? positions.enemy_center];
	var bottom_daemon = position_daemon_map[? positions.enemy_bottom];
	
	var top_alive = top_daemon.hp > 0;
	var center_alive = center_daemon.hp > 0;
	var bottom_alive = bottom_daemon.hp > 0;
	
	if (top_alive && !center_alive && !bottom_alive)
	{
		return positions.enemy_top;
	}
	else if (!top_alive && center_alive && !bottom_alive)
	{
		return positions.enemy_center;
	}
	else if (!top_alive && !center_alive && bottom_alive)
	{
		return positions.enemy_bottom;
	}
	else
	{
		return noone;
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

//Return all living target positions that a given position with a given set of targets could feasibly hit.
function get_possible_living_target_positions(user_position, targets)
{
	var possible_targets = get_possible_target_positions(user_position, targets);
	var to_return = []
	for (var i=0; i < array_length(possible_targets); i++)
	{
		if (position_daemon_map[? possible_targets[i]].hp > 0)
		{
			array_push(to_return, possible_targets[i]);
		}
	}
	return to_return;
}

//Return all the target positions that a given position with a given set of targets could feasibly hit. Does not take hp into account.
function get_possible_target_positions(user_position, targets)
{
	switch (targets)
	{
		case targets.single_enemy:
		case targets.all_enemies:
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
		
		case targets.self_only:
			return [selected_daemon.position];
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
		
		var hand_list_plus_move = ds_list_create();
		ds_list_copy(hand_list_plus_move, selected_battle_daemon.hand_list);
		ds_list_add(hand_list_plus_move, global.data_controller.move_move_data)
		ds_list_shuffle(hand_list_plus_move);
		
		for (var j=0; j < ds_list_size(hand_list_plus_move); j++)
		{
			if (array_length(get_possible_living_target_positions(user_position_order[i], hand_list_plus_move[| j].targets)) == 0)
			{
				continue;
			}
			var cost = hand_list_plus_move[| j].cost;
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
		
		selected_battle_daemon.selected_move = ds_list_find_value(hand_list_plus_move, selected_move_index);
		var target_position_order = array_shuffle(get_possible_living_target_positions(user_position_order[i], hand_list_plus_move[| j].targets));
		if (selected_battle_daemon.selected_move.targets == targets.all_allies || selected_battle_daemon.selected_move.targets == targets.all_enemies)
		{
			selected_battle_daemon.selected_targets = target_position_order;
		}
		else
		{
			selected_battle_daemon.selected_targets = [target_position_order[0]];
		}
		ds_list_destroy(hand_list_plus_move);
	}
}

function calculate_effect_damage(effect, class, using_daemon, target_daemon)
{
	var damage = 0;
	
	if (effect[0] == effects.physical_damage)
	{
		damage += effect[1] + using_daemon.physical_attack;
		for (var k=0; k < array_length(target_daemon.classes); k++)
		{
			var multiplier = 1;
			if (array_contains(get_class_weaknesses(target_daemon.classes[k]), class))
			{
				multiplier += ATTACK_OUTCLASS_DAMAGE_MULTIPLIER - 1;
			}
			if (array_contains(get_class_strengths(target_daemon.classes[k]), class))
			{
				multiplier += DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER - 1;
			}
			for (var i=0; i < ds_list_size(target_daemon.status_effect_list); i++)
			{
				if (target_daemon.status_effect_list[| i].status_effect == status_effects.vulnerable)
				{
					multiplier += VULNERABLE_DAMAGE_MULTIPLIER - 1;
				}
			}
			for (var i=0; i < ds_list_size(using_daemon.status_effect_list); i++)
			{
				if (using_daemon.status_effect_list[| i].status_effect == status_effects.strengthened)
				{
					multiplier += STRENGTHENED_DAMAGE_MULTIPLIER - 1;
				}
			}
			damage *= multiplier;
			damage -= target_daemon.physical_defense;
		}
	}
	else if (effect[0] == effects.energy_damage)
	{
		damage += effect[1] + using_daemon.energy_attack;
		for (var k=0; k < array_length(target_daemon.classes); k++)
		{
			var multiplier = 1;
			if (array_contains(get_class_weaknesses(target_daemon.classes[k]), class))
			{
				multiplier += ATTACK_OUTCLASS_DAMAGE_MULTIPLIER - 1;
			}
			if (array_contains(get_class_strengths(target_daemon.classes[k]), class))
			{
				multiplier += DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER - 1;
			}
			if (battle_daemon_has_status_effect(target_daemon, status_effects.vulnerable))
			{
				multiplier += VULNERABLE_DAMAGE_MULTIPLIER - 1;
			}
			if (battle_daemon_has_status_effect(target_daemon, status_effects.strengthened))
			{
				multiplier += STRENGTHENED_DAMAGE_MULTIPLIER - 1;
			}
			damage *= multiplier;
			damage -= target_daemon.energy_defense;
		}
	}
	
	return max(floor(damage), 1);
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
			damage += calculate_effect_damage(move.effects[j], move.class, using_daemon, target_daemon);
		}

		array_push(result, damage);
	}
	
	return result;
}