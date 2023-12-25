function initialize_battle_daemon(obj, data, player_owned=false)
{
	var species_data = get_species_data(data.index);
	obj.sprite_index = species_data.sprite;
	obj.max_hp = species_data.hp;
	obj.hp = species_data.hp;
	obj.name = species_data.name;
	obj.classes = species_data.classes;
	obj.moves = data.moves;
	obj.initiative = species_data.initiative;
	for (var i=0; i < array_length(data.moves); i++)
	{
		ds_list_add(obj.deck_list, data.moves[i]);
	}
	ds_list_shuffle(obj.deck_list);
	obj.hand_size = species_data.hand_size;
	obj.physical_attack = species_data.physical_attack;
	obj.energy_attack = species_data.energy_attack;
	obj.physical_defense = species_data.physical_defense;
	obj.energy_defense = species_data.energy_defense;
	
	obj.player_owned = player_owned;
	
	
	//Enemies face the other way
	if (!player_owned)
	{
		obj.image_xscale = -1;
	}
}

function draw_card()
{
	if (ds_list_size(deck_list) > 0)
	{
		ds_list_add(hand_list, ds_list_find_value(deck_list, 0));
		ds_list_delete(deck_list, 0);
	}
	else if (ds_list_size(discard_list) > 0)
	{
		ds_list_copy(deck_list, discard_list);
		ds_list_clear(discard_list);
		ds_list_shuffle(deck_list);
		draw_card();
	}
	else
	{
		show_debug_message("No card in deck or discard!");
	}
}

//Given an array of battle daemons and a battle_phase, returns the oBattleDaemon with the highest speed
//that has not yet attacked that is planning to attack on the given phase that is alive or noone if none exist
function try_get_next_acting_battle_daemon(battle_daemon_array, phase)
{
	possible_actors = [];
	highest_initiative = -1;
	
	for (var i=0; i < array_length(battle_daemon_array); i++)
	{
		if (battle_daemon_array[i].selected_move == noone)
		{
			continue;
		}
		else
		{
			var is_in_phase = battle_daemon_array[i].selected_move.phase == phase;
			var has_not_attacked = !battle_daemon_array[i].attacked;
			var is_alive = battle_daemon_array[i].hp > 0;
			if (is_in_phase && has_not_attacked && is_alive)
			{
				var initiative = battle_daemon_array[i].initiative;
				if (initiative > highest_initiative)
				{
					highest_initiative = initiative;
					possible_actors = [battle_daemon_array[i]];
				}
				else if (initiative == highest_initiative)
				{
					array_push(possible_actors, battle_daemon_array[i]);
				}
			}
		}
	}
	
	if (array_equals(possible_actors, []))
	{
		return noone;
	}
	else
	{
		return possible_actors[irandom(array_length(possible_actors) - 1)];
	}
}

function battle_daemon_act(battle_daemon)
{
	battle_daemon_tick_infection(battle_daemon);
	battle_daemon_tick_status(battle_daemon);
	
	var move = battle_daemon.selected_move;
	if (move != noone)
	{
		for (var i=0; i < array_length(battle_daemon.selected_targets); i++)
		{
			var target_daemon = battle_daemon.selected_targets[i];
			var target_battle_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, target_daemon);
			if (target_battle_daemon.hp > 0 || move.can_target_dead)
			{
				for (var j=0; j < array_length(move.effects); j++)
				{
					switch (move.effects[j][0])
					{
						//Damage
						case effects.physical_damage:
							var damage = calculate_effect_damage(move.effects[j], move.class, battle_daemon, target_battle_daemon);
							battle_daemon_take_damage_at_position(target_daemon, damage);
				
							global.battle_animation_controller.num_ongoing_animations++;
							var created = instance_create_depth(target_battle_daemon.x, target_battle_daemon.y, -10, oDamageDisplay);
							created.amount = -damage;
						break;
					
						case effects.energy_damage:
							var damage = calculate_effect_damage(move.effects[j], move.class, battle_daemon, target_battle_daemon);
							battle_daemon_take_damage_at_position(target_daemon, damage);
				
							global.battle_animation_controller.num_ongoing_animations++;
							var created = instance_create_depth(target_battle_daemon.x, target_battle_daemon.y, -10, oDamageDisplay);
							created.amount = -damage;
						break;
			
						//Swap
						case effects.swap:
							swap_daemons(battle_daemon.position, target_daemon);
						break;
						
						//Status effects
						case effects.status_effect:
							battle_daemon_add_status_effect(target_battle_daemon, move.effects[j][1], move.effects[j][2]);
						break;
						
						//Heal
						case effects.heal:
							battle_daemon_heal_at_position(target_daemon, move.effects[j][1]);
							global.battle_animation_controller.num_ongoing_animations++;
							var created = instance_create_depth(target_battle_daemon.x, target_battle_daemon.y, -10, oDamageDisplay);
							created.amount = move.effects[j][1];
						break;
					}
				}
			}
		}
	}
	battle_daemon.attacked = true;
	battle_daemon.image_blend = c_white;
	battle_daemon.selected_move = noone;
	battle_daemon.selected_targets = [];
}

function battle_daemon_animate_move(battle_daemon)
{
	animate_move(battle_daemon.selected_move, battle_daemon, battle_daemon.selected_targets);
}

function battle_daemon_take_damage_at_position(position, damage)
{
	var battle_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, position);
	battle_daemon.hp = median(battle_daemon.hp - damage, 0, battle_daemon.max_hp);
}

function battle_daemon_heal_at_position(position, heal_amount)
{
	var battle_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, position);
	battle_daemon.hp = median(battle_daemon.hp + heal_amount, 0, battle_daemon.max_hp);
}

function battle_daemon_add_status_effect(battle_daemon, _status_effect, _duration)
{
	with (battle_daemon)
	{
		var status_effect_already_exists = false;
		for (i=0; i < ds_list_size(status_effect_list); i++)
		{
			//If the status effect already exists, set its duration to the new value if greater
			if (status_effect_list[| i].status_effect == _status_effect)
			{
				status_effect_already_exists = true;
				if (status_effect_list[| i].duration < _duration)
				{
					status_effect_list[| i].duration = _duration;
				}
			}
		}
		
		//If status effect doesn't already exist, add it
		if (!status_effect_already_exists)
		{
			ds_list_add(status_effect_list, {status_effect: _status_effect, duration: _duration});
		}
	}
}

//Ticks all of a daemon's status effects down by 1.
function battle_daemon_tick_status(battle_daemon)
{
	var status_effect_list = battle_daemon.status_effect_list;
	for (var i=0; i < ds_list_size(status_effect_list); i++)
	{
		status_effect_list[| i].duration --;
	}
	
	do 
	{
		var deleted_status = false;
		
		for (var i=0; i < ds_list_size(status_effect_list); i++)
		{
			if (status_effect_list[| i].duration == 0)
			{
				ds_list_delete(status_effect_list, i);
				deleted_status = true;
				break;
			}
		}
	}
	until (deleted_status == false)
}

function swap_daemons(position1, position2)
{
	var battle_daemon1 = ds_map_find_value(global.battle_controller.position_daemon_map, position1);
	var battle_daemon2 = ds_map_find_value(global.battle_controller.position_daemon_map, position2);
	
	ds_map_set(global.battle_controller.position_daemon_map, position1, battle_daemon2);
	ds_map_set(global.battle_controller.position_daemon_map, position2, battle_daemon1);
	
	battle_daemon1.position = position2;
	battle_daemon2.position = position1;
	
	battle_daemon_recalculate_targets(battle_daemon2);
}

//Recalculates the targets of a daemon that was recently swapped
function battle_daemon_recalculate_targets(battle_daemon)
{
	if (battle_daemon.selected_move != noone)
	{
		if (array_length(battle_daemon.selected_targets) == 1)
		{
			if (battle_daemon.selected_targets[0] == positions.enemy_top && battle_daemon.position == positions.player_bottom)
			{
				battle_daemon.selected_targets[0] = positions.enemy_center;
			}
			if (battle_daemon.selected_targets[0] == positions.player_top && battle_daemon.position == positions.enemy_bottom)
			{
				battle_daemon.selected_targets[0] = positions.player_center;
			}
			if (battle_daemon.selected_targets[0] == positions.enemy_bottom && battle_daemon.position == positions.player_top)
			{
				battle_daemon.selected_targets[0] = positions.enemy_center;
			}
			if (battle_daemon.selected_targets[0] == positions.player_bottom && battle_daemon.position == positions.enemy_top)
			{
				battle_daemon.selected_targets[0] = positions.player_center;
			}
		}
		else if (battle_daemon.selected_move.targets == targets.all_enemies || battle_daemon.selected_move.targets == targets.all_allies)
		{
			battle_daemon.selected_targets = get_possible_target_positions(battle_daemon.position, battle_daemon.selected_move.targets);
		}
	}
}

function get_class_modifier(attack_class, defending_daemon_classes)
{
	var result = 1.0;
	for (var i=0; i<array_length(defending_daemon_classes); i++)
	{
		if (array_contains(get_class_weaknesses(defending_daemon_classes[i]), attack_class))
		{
			result *= ATTACK_OUTCLASS_DAMAGE_MULTIPLIER;
		}
		if (array_contains(get_class_strengths(defending_daemon_classes[i]), attack_class))
		{
			result *= DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER;
		}
	}
	return result;
}

function battle_daemon_has_status_effect(battle_daemon, status_effect)
{
	for (var i=0; i < ds_list_size(battle_daemon.status_effect_list); i++)
	{
		if (battle_daemon.status_effect_list[| i].status_effect == status_effect)
		{
			return true;
		}
	}
	return false;
}

function battle_daemon_get_status_effect_duration(battle_daemon, status_effect)
{
	for (var i=0; i < ds_list_size(battle_daemon.status_effect_list); i++)
	{
		if (battle_daemon.status_effect_list[| i].status_effect == status_effect)
		{
			return battle_daemon.status_effect_list[| i].duration;
		}
	}
}

//Deals damage to a daemon equal to infection stacks if the daemon is infected.
function battle_daemon_tick_infection(battle_daemon)
{
	if (battle_daemon_has_status_effect(battle_daemon, status_effects.infected))
	{
		var damage = battle_daemon_get_status_effect_duration(battle_daemon, status_effects.infected);
		battle_daemon_take_damage_at_position(battle_daemon.position, damage);

		global.battle_animation_controller.num_ongoing_animations++;
		var created = instance_create_depth(target_battle_daemon.x, target_battle_daemon.y, -10, oDamageDisplay);
		created.damage = damage;
	}
}