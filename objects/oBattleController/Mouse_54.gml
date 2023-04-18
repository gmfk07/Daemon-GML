/// @description Clear selected daemon
if (selected_daemon != noone)
{
	selected_daemon.selected = false;
	selected_daemon.image_xscale /= SELECTED_IMAGE_SCALE;
	selected_daemon.image_yscale /= SELECTED_IMAGE_SCALE;
	
	selected_daemon = noone;

	for (var i = 0; i < ds_list_size(move_card_list); i++)
	{
		instance_destroy(ds_list_find_value(move_card_list, i));
	}
	ds_list_clear(move_card_list);
}