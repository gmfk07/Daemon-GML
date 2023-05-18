/// @description New daemon selected
if (phase == battle_phases.selecting)
{
	if (selected_daemon != noone)
	{
		selected_daemon.selected = false;
		selected_daemon.image_xscale /= SELECTED_IMAGE_SCALE;
		selected_daemon.image_yscale /= SELECTED_IMAGE_SCALE;
	}
	selected_daemon = other;
}

for (var i = 0; i < ds_list_size(move_card_list); i++)
{
	instance_destroy(ds_list_find_value(move_card_list, i));
}
ds_list_clear(move_card_list);

var moves_len = ds_list_size(selected_daemon.hand_list);

for (var i = 0; i < moves_len; i++)
{
	var created = instance_create_layer((room_width/(moves_len + 1))*(i + 1), room_height - sprite_get_height(sCardShell), "Cards", oMoveCard);
	created.move_index = i;
	created.move_name = ds_list_find_value(selected_daemon.hand_list, i).name;
	ds_list_add(move_card_list, created);
}