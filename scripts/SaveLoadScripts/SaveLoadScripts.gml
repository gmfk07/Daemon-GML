function save_room()
{
	var _battle_challenge_npc_num = instance_number(oBattleChallengeNPC);
	var _battle_wild_npc_num = instance_number(oBattleWildNPC);
	var _dialogue_npc_num = instance_number(oDialogueNPC);
	
	var room_struct =
	{
		player_x : oPlayer.x,
		player_y : oPlayer.y,
		battle_challenge_npc_num : _battle_challenge_npc_num,
		battle_challenge_npc_data: array_create(_battle_challenge_npc_num),
		battle_wild_npc_num: _battle_wild_npc_num,
		battle_wild_npc_data: array_create(_battle_wild_npc_num),
		dialogue_npc_num: _dialogue_npc_num,
		dialogue_npc_data: array_create(_dialogue_npc_num)
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
			triggered_combat: inst.triggered_combat
		}
	}
	
	//Fill battle_wild_npc_data
	for (var i=0; i < _battle_wild_npc_num; i++)
	{
		var inst = instance_find(oBattleWildNPC, i);
		
		room_struct.battle_wild_npc_data[i] = {
			x : inst.x,
			y : inst.y,
			battle_cutscene: inst.battle_cutscene,
			triggered_combat: inst.triggered_combat
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
			sprite_index : inst.sprite_index
		}
	}
	
	if (room_get_name(room) == "rOverworld")
	{
		global.room_data.room_overworld = room_struct;
	}
}

function load_room()
{
	var room_struct = 0;
	
	if (room_get_name(room) == "rOverworld")
	{
		room_struct = global.room_data.room_overworld;
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
	
	//Battle Challenge NPCs
	for (var i=0; i < room_struct.battle_challenge_npc_num; i++)
	{
		var data = room_struct.battle_challenge_npc_data[i];
		with (instance_create_layer(data.x, data.y, "Instances", oBattleChallengeNPC))
		{
			defeated = data.defeated;
			battle_cutscene = data.battle_cutscene;
			defeated_cutscene = data.defeated_cutscene;
			triggered_combat = data.triggered_combat;
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
	
	//Battle Wild NPCs
	for (var i=0; i < room_struct.battle_wild_npc_num; i++)
	{
		var data = room_struct.battle_wild_npc_data[i];
		with (instance_create_layer(data.x, data.y, "Instances", oBattleWildNPC))
		{
			battle_cutscene = data.battle_cutscene;
			triggered_combat = data.triggered_combat;
			if (triggered_combat && global.data_controller.overworld_flag == overworld_flags.victory)
			{
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
	
	//Dialogue NPCs
	for (var i=0; i < room_struct.dialogue_npc_num; i++)
	{
		var data = room_struct.dialogue_npc_data[i];
		with (instance_create_layer(data.x, data.y, "Instances", oDialogueNPC))
		{
			cutscene = data.cutscene;
			sprite_index = data.sprite_index;
		}
	}
	
	if (global.data_controller.overworld_flag != overworld_flags.defeat)
	{
		oPlayer.x = room_struct.player_x;
		oPlayer.y = room_struct.player_y;
	}
	
	global.data_controller.overworld_flag = overworld_flags.none;
}