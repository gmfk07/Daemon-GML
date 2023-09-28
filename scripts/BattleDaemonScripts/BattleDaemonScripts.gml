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
			var target_daemon = battle_daemon.selected_targets[i];
			var target_battle_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, target_daemon);
			for (var j=0; j < array_length(move.effects); j++)
			{
				switch (move.effects[j][0])
				{
					//Damage
					case effects.physical_damage:
						var damage = move.effects[j][1];
						damage += battle_daemon.physical_attack;
						for (var k=0; k < array_length(target_battle_daemon.classes); k++)
						{
							if (array_contains(get_class_weaknesses(target_battle_daemon.classes[k]), move.class))
							{
								damage *= ATTACK_OUTCLASS_DAMAGE_MULTIPLIER;
							}
							if (array_contains(get_class_strengths(target_battle_daemon.classes[k]), move.class))
							{
								damage *= DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER;
							}
						}
				
						battle_daemon_take_damage(target_daemon, damage, attack_types.physical);
				
						var created = instance_create_depth(x, y, -10, oDamageDisplay);
						created.damage = damage;
					break;
					
					case effects.energy_damage:
						var damage = move.effects[j][1];
						damage += battle_daemon.energy_attack;
						for (var k=0; k < array_length(target_battle_daemon.classes); k++)
						{
							if (array_contains(get_class_weaknesses(target_battle_daemon.classes[k]), move.class))
							{
								damage *= ATTACK_OUTCLASS_DAMAGE_MULTIPLIER;
							}
							if (array_contains(get_class_strengths(target_battle_daemon.classes[k]), move.class))
							{
								damage *= DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER;
							}
						}
				
						battle_daemon_take_damage(target_daemon, damage, attack_types.energy);
				
						var created = instance_create_depth(x, y, -10, oDamageDisplay);
						created.damage = damage;
					break;
			
					//Swap
					case effects.swap:
						swap_daemons(battle_daemon.position, target_daemon);
					break;
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
	var move = battle_daemon.selected_move;
	
	var card = instance_create_depth(room_width/2, room_height - 192, 0, oMoveCard);
	card.move = move;
	
	if (move.projectile_sprite != noone)
	{
		for (var i=0; i<array_length(battle_daemon.selected_targets); i++)
		{
			global.battle_controller.num_ongoing_animations++;
			var projectile = instance_create_depth(battle_daemon.x, battle_daemon.y, 0, oProjectile);
			projectile.origin_daemon = battle_daemon;
			projectile.target_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, battle_daemon.selected_targets[i]);
			projectile.projectile_speed = move.projectile_speed;
			projectile.move = move
			projectile.sprite_index = move.projectile_sprite;
		}
	}
	if (move.user_to_target_move)
	{
		global.battle_controller.num_ongoing_animations++;
		var target_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, battle_daemon.selected_targets[0]);
		battle_daemon.animating = true;
		battle_daemon.animation_target_x = target_daemon.x;
		battle_daemon.animation_target_y = target_daemon.y;
		battle_daemon.animation_move_speed = move.user_to_target_speed;
		battle_daemon.animation_trigger_act_on_end = true;
	}
	if (move.target_to_user_move)
	{
		global.battle_controller.num_ongoing_animations++;
		var target_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, battle_daemon.selected_targets[0]);
		target_daemon.animating = true;
		target_daemon.animation_target_x = battle_daemon.x;
		target_daemon.animation_target_y = battle_daemon.y;
		target_daemon.animation_move_speed = move.target_to_user_speed;
		//target daemon move can NOT ever trigger its own act on end, TODO for animations 2.0
		target_daemon.animation_trigger_act_on_end = false;
	}
}

function battle_daemon_take_damage(position, damage, attack_type)
{
	var battle_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, position);
	battle_daemon.hp = median(battle_daemon.hp - damage, 0, battle_daemon.max_hp);
}

function swap_daemons(position1, position2)
{
	var battle_daemon1 = ds_map_find_value(global.battle_controller.position_daemon_map, position1);
	var battle_daemon2 = ds_map_find_value(global.battle_controller.position_daemon_map, position2);
	/*var x1 = battle_daemon1.x;
	var y1 = battle_daemon1.y;
	
	battle_daemon1.x = battle_daemon2.x;
	battle_daemon1.y = battle_daemon2.y;
	battle_daemon2.x = x1;
	battle_daemon2.y = y1;*/
	
	ds_map_set(global.battle_controller.position_daemon_map, position1, battle_daemon2);
	ds_map_set(global.battle_controller.position_daemon_map, position2, battle_daemon1);
	
	battle_daemon1.position = position2;
	battle_daemon2.position = position1;
}