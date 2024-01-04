/// @description Load room
if (array_contains(visited_rooms, room_get_name(room)))
{
	if (room_get_name(room) == "rOverworld" || room_get_name(room) == "rIntro")
	{
		load_room();
	}
}
else
{
	array_push(visited_rooms, room_get_name(room));
}