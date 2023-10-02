/// @description Init vars, create oBattleDaemon, trigger new turn
global.battle_controller = self;

move_move_data =
{
	name: "Move",
	art: sMoveArt,
	class: classes.classless,
	cost: 0,
	targets: targets.single_ally_self_exclusive,
	phase: battle_phases.move,
	attack_type: attack_types.none,
	effects: [[effects.swap]],
	projectile_sprite: noone,
	projectile_speed: 0,
	user_to_target_move: true,
	user_to_target_speed: 6,
	target_to_user_move: true,
	target_to_user_speed: 6
}


move_claw_data =
{
	name: "Claw",
	art: sClawArt,
	class: classes.impulse,
	cost: 1,
	targets: targets.single_enemy,
	phase: battle_phases.prep,
	effects: [[effects.physical_damage, 2]],
	projectile_sprite: sProjectile,
	projectile_speed: 10,
	user_to_target_move: false,
	user_to_target_speed: 0,
	target_to_user_move: false,
	target_to_user_speed: 0
}

move_bite_data =
{
	name: "Bite",
	art: sBiteArt,
	class: classes.impulse,
	cost: 2,
	targets: targets.single_enemy,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 5]],
	projectile_sprite: sProjectile,
	projectile_speed: 8,
	user_to_target_move: false,
	user_to_target_speed: 0,
	target_to_user_move: false,
	target_to_user_speed: 0
}

player_top_daemon_data =
{
	sprite: sCaracara,
	name: "Caracara",
	hp: 7,
	initiative: 15,
	classes: [classes.null],
	moves: [move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_bite_data],
	hand_size: 3,
	physical_attack: 2,
	energy_attack: 0
}

player_center_daemon_data =
{
	sprite: sComcat,
	name: "Comcat II",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_bite_data, move_bite_data, move_bite_data, move_bite_data],
	hand_size: 5,
	physical_attack: 2,
	energy_attack: 0
}

player_bottom_daemon_data =
{
	sprite: sComcat,
	name: "Comcat III",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_claw_data],
	hand_size: 3,
	physical_attack: 2,
	energy_attack: 0
}

enemy_top_daemon_data =
{
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0
}

enemy_center_daemon_data =
{
	sprite: sKnightman,
	name: "Knightman",
	hp: 10,
	initiative: 10,
	classes: [classes.bulwark],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0
}

enemy_bottom_daemon_data =
{
	sprite: sComcat,
	name: "Comcat III",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0
}

position_daemon_map = ds_map_create();
var player_top_battle_daemon = instance_create_layer(room_width/3, room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_top_battle_daemon, player_top_daemon_data, true);
ds_map_add(position_daemon_map, positions.player_top, player_top_battle_daemon);
player_top_battle_daemon.position = positions.player_top;

var player_center_battle_daemon = instance_create_layer(room_width/3 + 64, 2*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_center_battle_daemon, player_center_daemon_data, true);
ds_map_add(position_daemon_map, positions.player_center, player_center_battle_daemon);
player_center_battle_daemon.position = positions.player_center;

var player_bottom_battle_daemon = instance_create_layer(room_width/3, 3*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(player_bottom_battle_daemon, player_bottom_daemon_data, true);
ds_map_add(position_daemon_map, positions.player_bottom, player_bottom_battle_daemon);
player_bottom_battle_daemon.position = positions.player_bottom;

var enemy_top_battle_daemon = instance_create_layer((room_width*2)/3, room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_top_battle_daemon, enemy_top_daemon_data, false);
ds_map_add(position_daemon_map, positions.enemy_top, enemy_top_battle_daemon);
enemy_top_battle_daemon.position = positions.enemy_top;

var enemy_center_battle_daemon = instance_create_layer((room_width*2)/3 - 64, 2*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_center_battle_daemon, enemy_center_daemon_data, false);
ds_map_add(position_daemon_map, positions.enemy_center, enemy_center_battle_daemon);
enemy_center_battle_daemon.position = positions.enemy_center;

var enemy_bottom_battle_daemon = instance_create_layer((room_width*2)/3, 3*room_height/5, "Instances", oBattleDaemon);
initialize_battle_daemon(enemy_bottom_battle_daemon, enemy_bottom_daemon_data, false);
ds_map_add(position_daemon_map, positions.enemy_bottom, enemy_bottom_battle_daemon);
enemy_bottom_battle_daemon.position = positions.enemy_bottom;

phase = battle_phases.selecting;
selected_daemon = noone;
selected_card = noone;
selected_targets = [];
move_card_list = ds_list_create();
move_animation_card = noone;
points = starting_points;
max_points = starting_points;

randomize();
start_new_turn();