function create_deckbuilding_cards()
{
    with (global.deckbuilding_controller)
    {
        for (var j=0; j <= floor(array_length(active_moves)/cards_per_row); j++)
        {
        	for (var i=0; i < min(cards_per_row, array_length(active_moves) - j * cards_per_row); i++)
        	{
        		var created = instance_create_layer(128 + i*156, 128 + j*216, "Instances", oDeckbuildingMoveCard);
        		created.move = get_move_data(active_moves[i + j*cards_per_row]);
        		created.index = j * cards_per_row + i;
        		created.is_used = true;
        		//Check for same class
        		if (created.move.class == classes.classless || created.move.class == species_data.classes[0] || (array_length(species_data.classes) == 2 && created.move.class == species_data.classes[1]))
        		{
        			created.same_class = true;
        		}
        	}
        }
        
        var iters = 0;
        for (var i = unused_index; i < array_length(unused_moves); i++)
        {
        	var created = instance_create_layer(128 + iters*156, room_height/2 + 256, "Instances", oDeckbuildingMoveCard);
        	created.move = get_move_data(unused_moves[i]);
        	created.index = i;
        	created.is_used = false;
        	//Check for same class
        	if (created.move.class == classes.classless || created.move.class == species_data.classes[0] || (array_length(species_data.classes) == 2 && created.move.class == species_data.classes[1]))
        	{
        		created.same_class = true;
        	}
        	iters++
        }
    }
}

function delete_deckbuilding_cards()
{
    with (oDeckbuildingMoveCard)
    {
        instance_destroy();
    }
}