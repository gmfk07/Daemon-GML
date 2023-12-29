/// @description Spawning
if (amount_spawned < max_to_spawn && !spawning)
{
	spawning = true;
	spawn_time = current_time + random_range(min_spawn_wait, max_spawn_wait);
}
//Check to see if we need to spawn
if (spawning && spawn_timer >= spawn_time)
{
	spawn_x = random_range(x, x + width);
	spawn_y = random_range(y, y + height);
	
	var npc = instance_create_layer(spawn_x, spawn_y, "Instances", oBattleWildNPC);
	
	battle = battles[random_range(0, array_length(battles)-1)];
	
	var top_daemon = {
		index: battle[0],
		moves: get_all_unlocked_moves(battle[0], battle[1]),
		unused_moves: []
	}
	var center_daemon = {
		index: battle[2],
		moves: get_all_unlocked_moves(battle[2], battle[3]),
		unused_moves: []
	}
	var bottom_daemon = {
		index: battle[4],
		moves: get_all_unlocked_moves(battle[4], battle[5]),
		unused_moves: []
	}
	
	npc.battle_cutscene = [[cutscene_battle, top_daemon, center_daemon, bottom_daemon, battle_types.wild]];
	npc.spawned_by = spawner_id;
	
	amount_spawned++;
	
	if (amount_spawned >= max_to_spawn)
	{
		spawning = false;
	}
	else
	{
		//Continue spawning
		spawn_time = current_time + random_range(min_spawn_wait, max_spawn_wait);
	}
}
		
spawn_timer = current_time;