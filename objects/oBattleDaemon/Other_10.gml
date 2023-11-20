/// @description New turn
//Discard old hand and draw new hand
for (var i=0; i < ds_list_size(hand_list); i++)
{
	ds_list_add(discard_list, ds_list_find_value(hand_list, i));
}

ds_list_clear(hand_list);

for (var i=0; i < hand_size; i++)
{
	draw_card();
}

//Status
battle_daemon_tick_status(self);