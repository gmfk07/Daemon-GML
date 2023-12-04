/// @description Init vars, create cards
global.deckbuilding_controller = self;
daemon_data = global.data_controller.deckbuilding_daemon;
active_moves = daemon_data.moves;
unused_moves = daemon_data.unused_moves;

for (var i=0; i < array_length(active_moves); i++)
{
	var created = instance_create_layer(128 + i*156, 128, "Instances", oDeckbuildingMoveCard);
	created.move = active_moves[i];
	created.index = i;
	created.is_used = true;
	//Check for same class
	if (created.move.class == classes.classless || created.move.class == daemon_data.classes[0] || (array_length(daemon_data.classes) == 2 && created.move.class == daemon_data.classes[1]))
	{
		created.same_class = true;
	}
}

for (var i=0; i < array_length(unused_moves); i++)
{
	var created = instance_create_layer(128 + i*156, room_height/2, "Instances", oDeckbuildingMoveCard);
	created.move = unused_moves[i];
	created.index = i;
	created.is_used = false;
	//Check for same class
	if (created.move.class == classes.classless || created.move.class == daemon_data.classes[0] || (array_length(daemon_data.classes) == 2 && created.move.class == daemon_data.classes[1]))
	{
		created.same_class = true;
	}
}