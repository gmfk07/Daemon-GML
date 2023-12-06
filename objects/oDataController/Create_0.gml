/// @description Init vars
global.data_controller = self;
daemon_data_map = ds_map_create();
daemon_reserve_list = ds_list_create();

move_move_data =
{
	name: "Move",
	art: sMoveArt,
	class: classes.classless,
	cost: 0,
	targets: targets.single_ally_self_exclusive,
	can_target_dead: true,
	phase: battle_phases.move,
	attack_type: attack_types.none,
	effects: [[effects.swap]],
	animation: [[animation_swap, 6], [animation_act]]
}


move_claw_data =
{
	name: "Claw",
	art: sClawArt,
	class: classes.impulse,
	cost: 1,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.prep,
	effects: [[effects.physical_damage, 2]],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_bite_data =
{
	name: "Bite",
	art: sBiteArt,
	class: classes.impulse,
	cost: 2,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 5]],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_burst_data =
{
	name: "Burst",
	art: sExplodeArt,
	class: classes.impulse,
	cost: 3,
	targets: targets.all_enemies,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 3]],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_omegabite_data =
{
	name: "Omega Bite",
	art: sBiteArt,
	class: classes.impulse,
	cost: 3,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 7]],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_shatter_data =
{
	name: "Shatter",
	art: sExplodeArt,
	class: classes.impulse,
	cost: 2,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 2], [effects.status_effect, status_effects.vulnerable, 3]],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_clash_data =
{
	name: "Clash",
	art: sBiteArt,
	class: classes.bulwark,
	cost: 2,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 5]],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_bolster_data =
{
	name: "Bolster",
	art: sBiteArt,
	class: classes.bulwark,
	cost: 2,
	targets: targets.self_only,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.status_effect, status_effects.strengthened, 3]],
	animation: [[animation_act]]
}

player_top_daemon_data =
{
	sprite: sCaracara,
	name: "Caracara",
	hp: 7,
	initiative: 15,
	classes: [classes.null],
	moves: [move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_bite_data],
	unused_moves: [move_claw_data],
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
	moves: [move_claw_data, move_bite_data, move_shatter_data, move_bite_data, move_bite_data, move_burst_data, move_omegabite_data],
	unused_moves: [move_claw_data],
	hand_size: 5,
	physical_attack: 2,
	energy_attack: 0
}

player_bottom_daemon_data =
{
	sprite: sComcat,
	name: "Comcat II",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_bite_data, move_shatter_data, move_bite_data, move_bite_data, move_burst_data, move_omegabite_data],
	unused_moves: [move_claw_data],
	hand_size: 5,
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
	moves: [move_clash_data, move_clash_data, move_clash_data],
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

ds_map_add(daemon_data_map, positions.player_top, player_top_daemon_data);
ds_map_add(daemon_data_map, positions.player_center, player_center_daemon_data);
ds_map_add(daemon_data_map, positions.player_bottom, player_bottom_daemon_data);
ds_map_add(daemon_data_map, positions.enemy_top, player_top_daemon_data);
ds_map_add(daemon_data_map, positions.enemy_center, player_center_daemon_data);
ds_map_add(daemon_data_map, positions.enemy_bottom, player_bottom_daemon_data);

reserve_daemon_data1 =
{
	sprite: sKnightman,
	name: "Knightman",
	hp: 10,
	initiative: 10,
	classes: [classes.bulwark],
	moves: [move_clash_data, move_clash_data, move_clash_data],
	unused_moves: [move_claw_data, move_bolster_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0
}
reserve_daemon_data2 =
{
	sprite: sCaracara,
	name: "Caracara",
	hp: 7,
	initiative: 15,
	classes: [classes.null],
	moves: [move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_bite_data],
	unused_moves: [move_claw_data],
	hand_size: 3,
	physical_attack: 2,
	energy_attack: 0
}
ds_list_add(daemon_reserve_list, reserve_daemon_data1);
ds_list_add(daemon_reserve_list, reserve_daemon_data2);

global.room_data =
{
	room_overworld : 0
}

room_goto(rOverworld);

victory_cutscene = [];
defeat_cutscene = [[cutscene_dialogue, ["You were defeated..."]]];
overworld_flag = overworld_flags.none;
battle_type = battle_types.challenge;
deckbuilding_daemon = noone;