function initialize_battle_daemon(obj, data, player_owned=false)
{
	obj.sprite_index = data.sprite;
	obj.max_hp = data.hp;
	obj.hp = data.hp;
	obj.name = data.name;
	obj.classes = data.classes;
	obj.moves = data.moves;
	obj.initiative = data.initiative;
	for (var i=0; i < array_length(data.moves); i++)
	{
		ds_list_add(obj.deck_list, data.moves[i]);
	}
	obj.hand_size = data.hand_size;
	obj.physical_attack = data.physical_attack;
	obj.energy_attack = data.energy_attack;
	
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
//that has not yet attacked that is planning to attack on the given phase or noone if none exist
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
			if (is_in_phase && has_not_attacked)
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
	var move = battle_daemon.selected_move;
	if (move != noone)
	{
		for (var i=0; i < array_length(battle_daemon.selected_targets); i++)
		{
			//Damage
			if (move.damage > 0)
			{
				var damage = move.damage;
				
				if (move.attack_type == attack_types.physical)
				{
					damage += battle_daemon.physical_attack;
				}
				else if (move.attack_type == attack_types.energy)
				{
					damage += battle_daemon.energy_attack;
				}
				
				battle_daemon_take_damage(battle_daemon.selected_targets[i], damage);
			}
			
			//Effects
			for (var j=0; j < array_length(move.effects); j++)
			{
				if (move.effects[j] == effects.swap)
				{
					swap_daemons(battle_daemon.position, battle_daemon.selected_targets[i]);
				}
			}
		}
	}
	battle_daemon.attacked = true;
	battle_daemon.image_blend = c_white;
	battle_daemon.selected_move = noone;
	battle_daemon.selected_targets = [];
}

function battle_daemon_take_damage(position, damage)
{
	var battle_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, position);
	battle_daemon.hp = median(battle_daemon.hp - damage, 0, battle_daemon.max_hp);
}

function swap_daemons(position1, position2)
{
	var battle_daemon1 = ds_map_find_value(global.battle_controller.position_daemon_map, position1);
	var battle_daemon2 = ds_map_find_value(global.battle_controller.position_daemon_map, position2);
	var x1 = battle_daemon1.x;
	var y1 = battle_daemon1.y;
	
	battle_daemon1.x = battle_daemon2.x;
	battle_daemon1.y = battle_daemon2.y;
	battle_daemon2.x = x1;
	battle_daemon2.y = y1;
	
	ds_map_set(global.battle_controller.position_daemon_map, position1, battle_daemon2);
	ds_map_set(global.battle_controller.position_daemon_map, position2, battle_daemon1);
	
	battle_daemon1.position = position2;
	battle_daemon2.position = position1;
}