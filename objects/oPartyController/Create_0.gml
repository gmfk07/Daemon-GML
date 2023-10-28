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
