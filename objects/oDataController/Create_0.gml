/// @description Init vars
global.data_controller = self;
daemon_data_map = ds_map_create();
daemon_reserve_list = ds_list_create();
daemon_species_list = ds_list_create();

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

move_quickswap_data =
{
	name: "Quick Swap",
	art: sMoveArt,
	class: classes.impulse,
	cost: 1,
	targets: targets.single_ally_self_exclusive,
	can_target_dead: true,
	phase: battle_phases.prep,
	attack_type: attack_types.none,
	effects: [[effects.swap]],
	animation: [[animation_swap, 6], [animation_act]]
}

move_poke_data =
{
	name: "Poke",
	art: sClawArt,
	class: classes.impulse,
	cost: 0,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 1]],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
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

move_dark_stab_data =
{
	name: "Dark Stab",
	art: sBiteArt,
	class: classes.penumbra,
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

//Populate species data
var comcat_data = {
	sprite: sComcat,
	name: "Comcat II",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	starting_moves: [move_quickswap_data, move_claw_data, move_claw_data, move_bite_data, move_bite_data, move_bite_data],
	unlocked_moves: [[move_poke_data]],
	hand_size: 5,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 2,
	energy_defense: 0
}

var caracara_data = {
	sprite: sCaracara,
	name: "Caracara",
	hp: 7,
	initiative: 15,
	classes: [classes.null],
	starting_moves: [move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_claw_data, move_bite_data],
	unlocked_moves: [[move_claw_data]],
	hand_size: 3,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 2,
	energy_defense: 0
}

var knightman_data = {
	sprite: sKnightman,
	name: "Knightman",
	hp: 10,
	initiative: 10,
	classes: [classes.bulwark],
	starting_moves: [move_clash_data, move_clash_data, move_clash_data],
	unlocked_moves: [[move_clash_data, move_bolster_data]],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 3,
	energy_defense: 0
}

var skull_data = {
	sprite: sSkull,
	name: "Skull",
	hp: 14,
	initiative: 5,
	classes: [classes.penumbra],
	starting_moves: [move_clash_data, move_clash_data, move_clash_data],
	unlocked_moves: [[move_dark_stab_data, move_dark_stab_data]],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 1,
	physical_defense: 2,
	energy_defense: 0
}

var eyebot_data = {
	sprite: sEyebot,
	name: "Eyebot",
	hp: 8,
	initiative: 20,
	classes: [classes.advent],
	starting_moves: [move_clash_data, move_clash_data, move_clash_data],
	unlocked_moves: [[move_dark_stab_data, move_dark_stab_data]],
	hand_size: 4,
	physical_attack: 0,
	energy_attack: 3,
	physical_defense: 1,
	energy_defense: 1
}

var jouwel_data = {
	sprite: sJouwel,
	name: "Jouwel",
	hp: 8,
	initiative: 5,
	classes: [classes.element],
	starting_moves: [move_clash_data, move_clash_data, move_clash_data],
	unlocked_moves: [[move_dark_stab_data, move_dark_stab_data]],
	hand_size: 4,
	physical_attack: 0,
	energy_attack: 3,
	physical_defense: 3,
	energy_defense: 0
}

ds_list_add(daemon_species_list, comcat_data, caracara_data, knightman_data, skull_data, eyebot_data, jouwel_data);

player_top_daemon_data =
{
	index: 0,
	moves: get_all_unlocked_moves(0, 1),
	unused_moves: [],
	level: 1,
	experience: 0
}

player_center_daemon_data =
{
	index: 1,
	moves: get_all_unlocked_moves(1, 1),
	unused_moves: [],
	level: 1,
	experience: 0
}

player_bottom_daemon_data =
{
	index: 2,
	moves: get_all_unlocked_moves(2, 1),
	unused_moves: [],
	level: 1,
	experience: 0
}

enemy_top_daemon_data =
{
	index: 0,
	moves: [move_claw_data, move_claw_data, move_claw_data],
}

enemy_center_daemon_data =
{
	index: 2,
	moves: [move_clash_data, move_clash_data, move_clash_data],
}

enemy_bottom_daemon_data =
{
	index: 0,
	moves: [move_claw_data, move_claw_data, move_claw_data],
}

ds_map_add(daemon_data_map, positions.player_top, player_top_daemon_data);
ds_map_add(daemon_data_map, positions.player_center, player_center_daemon_data);
ds_map_add(daemon_data_map, positions.player_bottom, player_bottom_daemon_data);
ds_map_add(daemon_data_map, positions.enemy_top, player_top_daemon_data);
ds_map_add(daemon_data_map, positions.enemy_center, player_center_daemon_data);
ds_map_add(daemon_data_map, positions.enemy_bottom, player_bottom_daemon_data);

reserve_daemon_data1 =
{
	index: 3,
	moves: get_all_unlocked_moves(3, 1),
	unused_moves: [],
	level: 1,
	experience: 0
}
reserve_daemon_data2 =
{
	index: 4,
	moves: get_all_unlocked_moves(4, 1),
	unused_moves: [],
	level: 1,
	experience: 0
}
reserve_daemon_data3 =
{
	index: 5,
	moves: get_all_unlocked_moves(5, 1),
	unused_moves: [],
	level: 1,
	experience: 0
}
ds_list_add(daemon_reserve_list, reserve_daemon_data1);
ds_list_add(daemon_reserve_list, reserve_daemon_data2);
ds_list_add(daemon_reserve_list, reserve_daemon_data3);

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