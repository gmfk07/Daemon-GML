function save_room()
{
	var room_struct =
	{
		player_x : oPlayer.x,
		player_y : oPlayer.y
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
	
	oPlayer.x = room_struct.player_x;
	oPlayer.y = room_struct.player_y;
}