/// @description Init vars, create oBattleDaemon, trigger new turn
global.battle_controller = self;

move_claw_data =
{
	name: "Claw",
	art: sClawArt,
	class: classes.impulse,
	cost: 1,
	damage: 2,
	targets: targets.single_enemy
}

move_bite_data =
{
	name: "Bite",
	art: sClawArt,
	class: classes.impulse,
	cost: 2,
	damage: 4,
	targets: targets.single_enemy
}

player_top_daemon_data =
{
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	speed: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 3
}

player_center_daemon_data =
{
	sprite: sComcat,
	name: "Comcat II",
	hp: 10,
	speed: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 3
}

player_bottom_daemon_data =
{
	sprite: sComcat,
	name: "Comcat III",
	hp: 10,
	speed: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 3
}

enemy_top_daemon_data =
{
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	speed: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 4
}

enemy_center_daemon_data =
{
	sprite: sComcat,
	name: "Comcat II",
	hp: 10,
	speed: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 4
}

enemy_bottom_daemon_data =
{
	sprite: sComcat,
	name: "Comcat III",
	hp: 10,
	speed: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 4
}

player_top_battle_daemon = instance_create_layer(room_width/3, room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_top_battle_daemon, player_top_daemon_data, true);

player_center_battle_daemon = instance_create_layer(room_width/3 + 64, 2*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_center_battle_daemon, player_center_daemon_data, true);

player_bottom_battle_daemon = instance_create_layer(room_width/3, 3*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_bottom_battle_daemon, player_bottom_daemon_data, true);

enemy_top_battle_daemon = instance_create_layer((room_width*2)/3, room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_top_battle_daemon, enemy_top_daemon_data, false);

enemy_center_battle_daemon = instance_create_layer((room_width*2)/3 - 64, 2*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_center_battle_daemon, enemy_center_daemon_data, false);

enemy_bottom_battle_daemon = instance_create_layer((room_width*2)/3, 3*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_bottom_battle_daemon, enemy_bottom_daemon_data, false);

phase = battle_phases.selecting;
selected_daemon = noone;
selected_card = noone;
selected_targets = [];
move_card_list = ds_list_create();

start_new_turn();