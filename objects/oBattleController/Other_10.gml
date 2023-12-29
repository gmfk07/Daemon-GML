/// @description New daemon selected
if (phase == battle_phases.selecting)
{
	for (var i = 0; i < ds_list_size(move_card_list); i++)
	{
		instance_destroy(ds_list_find_value(move_card_list, i));
	}
	ds_list_clear(move_card_list);

	var moves_len = ds_list_size(selected_daemon.hand_list);
	var card_count = moves_len + 1;

	for (var i = 0; i < moves_len; i++)
	{
		var created = instance_create_layer((room_width/(card_count + 1))*(i + 1), 2*sprite_get_height(sCardShell)/3, "Cards", oBattleMoveCard);
		created.move = ds_list_find_value(selected_daemon.hand_list, i);
		
		//Check for same class
		if (created.move.class == classes.classless || created.move.class == selected_daemon.classes[0] || (array_length(selected_daemon.classes) == 2 && created.move.class == selected_daemon.classes[1]))
		{
			created.same_class = true;
		}
		
		ds_list_add(move_card_list, created);
	}
	
	//Add move card
	var created = instance_create_layer((room_width/(card_count + 1))*(i + 1), 2*sprite_get_height(sCardShell)/3, "Cards", oBattleMoveCard);
	created.move = move_move_data;
	created.same_class = true;
	ds_list_add(move_card_list, created);
}