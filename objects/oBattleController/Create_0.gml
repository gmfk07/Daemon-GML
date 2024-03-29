/// @description Init vars, create oBattleDaemon, trigger new turn
global.battle_controller = self;

player_top_daemon_data = get_daemon_data_from_position(positions.player_top);
player_center_daemon_data = get_daemon_data_from_position(positions.player_center);
player_bottom_daemon_data = get_daemon_data_from_position(positions.player_bottom);
enemy_top_daemon_data = get_daemon_data_from_position(positions.enemy_top);
enemy_center_daemon_data = get_daemon_data_from_position(positions.enemy_center);
enemy_bottom_daemon_data = get_daemon_data_from_position(positions.enemy_bottom);

//Move is a special move and must be known by oBattleController
move_move_data = global.data_controller.move_move_data;

position_daemon_map = ds_map_create();
var player_top_battle_daemon = instance_create_layer(room_width/3, 2*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_top_battle_daemon, player_top_daemon_data, true);
ds_map_add(position_daemon_map, positions.player_top, player_top_battle_daemon);
player_top_battle_daemon.position = positions.player_top;

var player_center_battle_daemon = instance_create_layer(room_width/3 + 64, 3*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_center_battle_daemon, player_center_daemon_data, true);
ds_map_add(position_daemon_map, positions.player_center, player_center_battle_daemon);
player_center_battle_daemon.position = positions.player_center;

var player_bottom_battle_daemon = instance_create_layer(room_width/3, 4*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_bottom_battle_daemon, player_bottom_daemon_data, true);
ds_map_add(position_daemon_map, positions.player_bottom, player_bottom_battle_daemon);
player_bottom_battle_daemon.position = positions.player_bottom;

var enemy_top_battle_daemon = instance_create_layer((room_width*2)/3, 2*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_top_battle_daemon, enemy_top_daemon_data, false);
ds_map_add(position_daemon_map, positions.enemy_top, enemy_top_battle_daemon);
enemy_top_battle_daemon.position = positions.enemy_top;

var enemy_center_battle_daemon = instance_create_layer((room_width*2)/3 - 64, 3*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_center_battle_daemon, enemy_center_daemon_data, false);
ds_map_add(position_daemon_map, positions.enemy_center, enemy_center_battle_daemon);
enemy_center_battle_daemon.position = positions.enemy_center;

var enemy_bottom_battle_daemon = instance_create_layer((room_width*2)/3, 4*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_bottom_battle_daemon, enemy_bottom_daemon_data, false);
ds_map_add(position_daemon_map, positions.enemy_bottom, enemy_bottom_battle_daemon);
enemy_bottom_battle_daemon.position = positions.enemy_bottom;

phase = battle_phases.selecting;
selected_daemon = noone;
selected_card = noone;
selected_targets = [];
move_card_list = ds_list_create();
move_animation_card = noone;
catch_button = noone;
//Every turn we increase max_points, so set max_points to 1 less than starting
max_points = starting_points - 1;
battle_type = global.data_controller.battle_type;

randomize();
start_new_turn();