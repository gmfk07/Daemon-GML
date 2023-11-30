function save_room()
{
	var _battle_npc_num = instance_number(oBattleChallengeNPC);
	
	var room_struct =
	{
		player_x : oPlayer.x,
		player_y : oPlayer.y,
		battle_npc_num : _battle_npc_num,
		battle_npc_data: array_create(_battle_npc_num),
	}
	
	//Fill battle_npc_data
	for (var i=0; i < _battle_npc_num; i++)
	{
		var inst = instance_find(oBattleChallengeNPC, i);
		
		room_struct.battle_npc_data[i] = {
			x : inst.x,
			y : inst.y,
			defeated: inst.defeated,
			battle_cutscene: inst.battle_cutscene,
			defeated_cutscene: inst.defeated_cutscene,
			triggered_combat: inst.triggered_combat
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
	for (var i=0; i < room_struct.battle_npc_num; i++)
	{
		var data = room_struct.battle_npc_data[i];
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
	
	if (global.data_controller.overworld_flag != overworld_flags.defeat)
	{
		oPlayer.x = room_struct.player_x;
		oPlayer.y = room_struct.player_y;
	}
	
	global.data_controller.overworld_flag = overworld_flags.none;
}