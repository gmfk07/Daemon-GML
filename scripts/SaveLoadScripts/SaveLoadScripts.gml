function save_room()
{
	var battle_npc_num = instance_number(oBattleNPC);
	
	var room_struct =
	{
		player_x : oPlayer.x,
		player_y : oPlayer.y,
		battle_npc_data: array_create(battle_npc_num),
	}
	
	//Fill battle_npc_data
	for (var i=0; i < battle_npc_num; i++)
	{
		var inst = instance_find(oBattleNPC, i);
		
		room_struct.battle_npc_data[i] = {
			
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
	
	if (global.data_controller.overworld_flag == overworld_flags.defeat)
	{
		if (global.data_controller.defeat_cutscene != [])
		{
			start_cutscene(global.data_controller.defeat_cutscene);
		}
	}
	if (global.data_controller.overworld_flag == overworld_flags.defeat)
	{
		if (global.data_controller.defeat_cutscene != [])
		{
			start_cutscene(global.data_controller.defeat_cutscene);
		}
	}
	
	if (!is_struct(room_struct))
	{
		exit;
	}
	
	if (global.data_controller.overworld_flag != overworld_flags.defeat)
	{
		oPlayer.x = room_struct.player_x;
		oPlayer.y = room_struct.player_y;
	}
	
	global.data_controller.overworld_flag = overworld_flags.none;
}