/// @description Save room
if (room_get_name(room) == "rOverworld" || room_get_name(room) == "rIntro")
{
	save_room();
	last_overworld_room = room;
}