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
		var created = instance_create_layer((room_width/(card_count + 1))*(i + 1), room_height - sprite_get_height(sCardShell)/2 - 32, "Cards", oMoveCard);
		created.move = ds_list_find_value(selected_daemon.hand_list, i);
		ds_list_add(move_card_list, created);
	}
	//Add move card
	var created = instance_create_layer((room_width/(card_count + 1))*(i + 1), room_height - sprite_get_height(sCardShell)/2 - 32, "Cards", oMoveCard);
	created.move = move_move_data;
	ds_list_add(move_card_list, created);
}