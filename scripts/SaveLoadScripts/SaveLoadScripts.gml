function save_room()
{
	var _battle_challenge_npc_num = instance_number(oBattleChallengeNPC);
	var _battle_wild_npc_num = instance_number(oBattleWildNPC);
	var _dialogue_npc_num = instance_number(oDialogueNPC);
	var _battle_wild_npc_spawner_num = instance_number(oBattleWildNPCSpawner);
	var _player_trigger_num = instance_number(oPlayerTrigger);
	
	var room_struct =
	{
		player_x : oPlayer.x,
		player_y : oPlayer.y,
		battle_challenge_npc_num : _battle_challenge_npc_num,
		battle_challenge_npc_data: array_create(_battle_challenge_npc_num),
		battle_wild_npc_num: _battle_wild_npc_num,
		battle_wild_npc_data: array_create(_battle_wild_npc_num),
		dialogue_npc_num: _dialogue_npc_num,
		dialogue_npc_data: array_create(_dialogue_npc_num),
		battle_wild_npc_spawner_num: _battle_wild_npc_spawner_num,
		battle_wild_npc_spawner_data: array_create(_battle_wild_npc_spawner_num),
		player_trigger_num: _player_trigger_num,
		player_trigger_data: array_create(_player_trigger_num)
	}
	
	//Fill battle_challenge_npc_data
	for (var i=0; i < _battle_challenge_npc_num; i++)
	{
		var inst = instance_find(oBattleChallengeNPC, i);
		
		room_struct.battle_challenge_npc_data[i] = {
			x : inst.x,
			y : inst.y,
			defeated: inst.defeated,
			battle_cutscene: inst.battle_cutscene,
			defeated_cutscene: inst.defeated_cutscene,
			cutscene: inst.cutscene,
			triggered_combat: inst.triggered_combat,
			npc_id: inst.npc_id
		}
	}
	
	//Fill battle_wild_npc_data
	for (var i=0; i < _battle_wild_npc_num; i++)
	{
		var inst = instance_find(oBattleWildNPC, i);
		
		room_struct.battle_wild_npc_data[i] = {
			x : inst.x,
			y : inst.y,
			home_x : inst.home_x,
			home_y : inst.home_y,
			battle_cutscene: inst.battle_cutscene,
			triggered_combat: inst.triggered_combat,
			spawned_by: inst.spawned_by
		}
	}
	
	//Fill dialogue_npc_data
	for (var i=0; i < _dialogue_npc_num; i++)
	{
		var inst = instance_find(oDialogueNPC, i);
		
		room_struct.dialogue_npc_data[i] = {
			x : inst.x,
			y : inst.y,
			cutscene: inst.cutscene,
			sprite_index : inst.sprite_index,
			is_battle_challenge_npc: inst.object_index == oBattleChallengeNPC,
			npc_id: inst.npc_id
		}
	}
	
	//Fill battle_wild_npc_spawner_data
	for (var i=0; i < _battle_wild_npc_spawner_num; i++)
	{
		var inst = instance_find(oBattleWildNPCSpawner, i);
		
		room_struct.battle_wild_npc_spawner_data[i] = {
			spawner_id: inst.spawner_id,
			x : inst.x,
			y : inst.y,
			amount_spawned: inst.amount_spawned,
			battles: inst.battles,
			min_spawn_wait: inst.min_spawn_wait,
			max_spawn_wait: inst.max_spawn_wait,
			max_to_spawn: inst.max_to_spawn,
			width: inst.width,
			height: inst.height
		}
	}
	
	//Fill player_trigger data
	for (var i=0; i < _player_trigger_num; i++)
	{
		var inst = instance_find(oPlayerTrigger, i);
		
		room_struct.player_trigger_data[i] = {
			x : inst.x,
			y : inst.y,
			cutscene: inst.cutscene,
			triggered: inst.triggered
		}
	}
	
	//Fill cutscene controller data
	var inst = global.cutscene_controller;
	
	if (room_get_name(room) == "rOverworld")
	{
		global.room_data.room_overworld = room_struct;
	}
	if (room_get_name(room) == "rIntro")
	{
		global.room_data.room_intro = room_struct;
	}
}

function load_room()
{
	var room_struct = 0;
	
	if (room_get_name(room) == "rOverworld")
	{
		room_struct = global.room_data.room_overworld;
	}
	if (room_get_name(room)== "rIntro")
	{
		room_struct = global.room_data.room_intro;
	}
	
	if (!is_struct(room_struct))
	{
		exit;
	}
	
	if (instance_exists(oBattleChallengeNPC))
	{
		instance_destroy(oBattleChallengeNPC);
	}
	
	if (instance_exists(oBattleWildNPC))
	{
		instance_destroy(oBattleWildNPC);
	}
	
	if (instance_exists(oDialogueNPC))
	{
		instance_destroy(oDialogueNPC);
	}
	
	if (instance_exists(oBattleWildNPCSpawner))
	{
		instance_destroy(oBattleWildNPCSpawner);
	}
	
	if (instance_exists(oPlayerTrigger))
	{
		instance_destroy(oPlayerTrigger);
	}
	
	//Battle Challenge NPCs
	for (var i=0; i < room_struct.battle_challenge_npc_num; i++)
	{
		var data = room_struct.battle_challenge_npc_data[i];
		with (instance_create_layer(data.x, data.y, "Instances", oBattleChallengeNPC))
		{
			defeated = data.defeated;
			battle_cutscene = data.battle_cutscene;
			defeated_cutscene = data.defeated_cutscene;
			cutscene = data.cutscene;
			triggered_combat = data.triggered_combat;
			npc_id = data.npc_id;
			if (triggered_combat && global.data_controller.overworld_flag == overworld_flags.victory)
			{
				defeated = true;
				start_cutscene(data.defeated_cutscene);
				triggered_combat = false;
			}
			else if (triggered_combat && global.data_controller.overworld_flag == overworld_flags.defeat)
			{
				if (global.data_controller.defeat_cutscene != [])
				{
					start_cutscene(global.data_controller.defeat_cutscene);
				}
				triggered_combat = false;
			}
		}
	}

	var spawner_id_to_update = -1;
	//Battle Wild NPCs
	for (var i=0; i < room_struct.battle_wild_npc_num; i++)
	{
		var data = room_struct.battle_wild_npc_data[i];
		with (instance_create_layer(data.x, data.y, "Instances", oBattleWildNPC))
		{
			battle_cutscene = data.battle_cutscene;
			triggered_combat = data.triggered_combat;
			spawned_by = data.spawned_by;
			home_x = data.home_x;
			home_y = data.home_y;
			
			if (triggered_combat && global.data_controller.overworld_flag == overworld_flags.victory)
			{
				//Check for parent spawner and update them on their child's death
				if (data.spawned_by != noone)
				{
					spawner_id_to_update = data.spawned_by;
				}
				
				instance_destroy();
			}
			else if (triggered_combat && global.data_controller.overworld_flag == overworld_flags.defeat)
			{
				if (global.data_controller.defeat_cutscene != [])
				{
					start_cutscene(global.data_controller.defeat_cutscene);
				}
				triggered_combat = false;
			}
		}
	}
	
	//Battle Wild NPC Spawners
	for (var i=0; i < room_struct.battle_wild_npc_spawner_num; i++)
	{
		var data = room_struct.battle_wild_npc_spawner_data[i];
		with (instance_create_layer(data.x, data.y, "Instances", oBattleWildNPCSpawner))
		{
				amount_spawned = data.spawner_id == spawner_id_to_update ? data.amount_spawned - 1 : data.amount_spawned;
				battles = data.battles;
				min_spawn_wait = data.min_spawn_wait;
				max_spawn_wait = data.max_spawn_wait;
				max_to_spawn = data.max_to_spawn;
				width = data.width;
				height = data.height;
		}
	}
	
	//Dialogue NPCs
	for (var i=0; i < room_struct.dialogue_npc_num; i++)
	{
		var data = room_struct.dialogue_npc_data[i];
		//Don't double-spawn battle challenge npcs
		if (!data.is_battle_challenge_npc)
		{
			with (instance_create_layer(data.x, data.y, "Instances", oDialogueNPC))
			{
				cutscene = data.cutscene;
				sprite_index = data.sprite_index;
				npc_id = data.npc_id
			}
		}
	}
	
	//Player Triggers
	for (var i=0; i < room_struct.player_trigger_num; i++)
	{
		var data = room_struct.player_trigger_data[i];
		
		with (instance_create_layer(data.x, data.y, "Instances", oPlayerTrigger))
		{
			cutscene = data.cutscene;
			triggered = data.triggered;
		}
	}
	
	if (global.data_controller.overworld_flag != overworld_flags.defeat)
	{
		oPlayer.x = room_struct.player_x;
		oPlayer.y = room_struct.player_y;
	}
	
	global.data_controller.overworld_flag = overworld_flags.none;
}