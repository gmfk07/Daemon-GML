/// @description Create slots
global.party_controller = self;
selected_party_daemon = noone;
selected_swap_daemon = noone;

top_slot = instance_create_layer(room_width/3, room_height/5, "Slots", oSlot);
top_slot.position = positions.player_top;
center_slot = instance_create_layer(room_width/3 + 64, 2*room_height/5, "Slots", oSlot);
center_slot.position = positions.player_center;
bottom_slot = instance_create_layer(room_width/3, 3*room_height/5, "Slots", oSlot);
bottom_slot.position = positions.player_bottom;

top_daemon = instance_create_layer(room_width/3, room_height/5, "Interactables", oPartyDaemon);
top_daemon.position = positions.player_top;
center_daemon = instance_create_layer(room_width/3 + 64, 2*room_height/5, "Interactables", oPartyDaemon);
center_daemon.position = positions.player_center;
bottom_daemon = instance_create_layer(room_width/3, 3*room_height/5, "Interactables", oPartyDaemon);
bottom_daemon.position = positions.player_bottom;

top_daemon.sprite_index = get_daemon_data_from_position(positions.player_top).sprite;
center_daemon.sprite_index = get_daemon_data_from_position(positions.player_center).sprite;
bottom_daemon.sprite_index = get_daemon_data_from_position(positions.player_bottom).sprite;

for (var i=0; i < ds_list_size(global.data_controller.daemon_reserve_list); i++)
{
	var reserve_daemon = instance_create_layer(64 + i*160, room_height - 64, "Interactables", oPartyDaemon);
	reserve_daemon.sprite_index = global.data_controller.daemon_reserve_list[| i].sprite;
	reserve_daemon.position = positions.reserve;
	reserve_daemon.reserve_index = i;
}