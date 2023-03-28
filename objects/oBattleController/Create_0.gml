/// @description Init vars, create oBattleDaemon
player_top_daemon_data =
{
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	speed: 10
}

player_center_daemon_data =
{
	sprite: sComcat,
	name: "Comcat II",
	hp: 10,
	speed: 10
}

player_bottom_daemon_data =
{
	sprite: sComcat,
	name: "Comcat III",
	hp: 10,
	speed: 10
}

enemy_top_daemon_data =
{
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	speed: 10
}

enemy_center_daemon_data =
{
	sprite: sComcat,
	name: "Comcat II",
	hp: 10,
	speed: 10
}

enemy_bottom_daemon_data =
{
	sprite: sComcat,
	name: "Comcat III",
	hp: 10,
	speed: 10
}

player_top_battle_daemon = instance_create_layer(room_width/3, room_height/4, "Instances", oBattleDaemon);
initialize_battle_daemon(player_top_battle_daemon, player_top_daemon_data, true);

player_center_battle_daemon = instance_create_layer(room_width/3 + 64, room_height/2, "Instances", oBattleDaemon);
initialize_battle_daemon(player_center_battle_daemon, player_center_daemon_data, true);

player_bottom_battle_daemon = instance_create_layer(room_width/3, room_height - room_height/4, "Instances", oBattleDaemon);
initialize_battle_daemon(player_bottom_battle_daemon, player_bottom_daemon_data, true);

enemy_top_battle_daemon = instance_create_layer((room_width*2)/3, room_height/4, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_top_battle_daemon, player_top_daemon_data, false);

enemy_center_battle_daemon = instance_create_layer((room_width*2)/3 - 64, room_height/2, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_center_battle_daemon, player_center_daemon_data, false);

enemy_bottom_battle_daemon = instance_create_layer((room_width*2)/3, room_height - room_height/4, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_bottom_battle_daemon, player_bottom_daemon_data, false);

phase = battle_phases.selecting;
selected_daemon = noone;