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
			if (move.damage > 0)
			{
				battle_daemon_take_damage(battle_daemon.selected_targets[i], move.damage);
			}
		}
	}
	battle_daemon.attacked = true;
	battle_daemon.image_blend = c_white;
	battle_daemon.selected_move = noone;
	battle_daemon.selected_targets = [];
}

function battle_daemon_take_damage(battle_daemon, damage)
{
	battle_daemon.hp = median(battle_daemon.hp - damage, 0, battle_daemon.max_hp);
}