/// @description Init vars
global.data_controller = self;
daemon_data_map = ds_map_create();
daemon_reserve_list = ds_list_create();
daemon_species_array = [];
daemon_move_array = [];

event_flags = ds_list_create();

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
	self_effects: [],
	restrictions: [],
	animation: [[animation_swap_target, 6], [animation_act]]
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
	self_effects: [],
	restrictions: [],
	animation: [[animation_swap_target, 6], [animation_act]]
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
	self_effects: [],
	restrictions: [],
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
	self_effects: [[effects.charge]],
	effects: [[effects.physical_damage, 2], [effects.status_effect, status_effects.physical_vulnerable, 3]],
	restrictions: [],
	animation: [[animation_swap_charge, 6], [animation_spawn_projectile, sProjectile, 8], [animation_act]]
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
	effects: [[effects.physical_damage, 6]],
	self_effects: [],
	restrictions: [[restrictions.frontline]],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_mend_data =
{
	name: "Mend",
	art: sMendArt,
	class: classes.impulse,
	cost: 1,
	targets: targets.self_only,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.heal, 5]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_act]]
}

move_herbal_remedy_data =
{
	name: "Herbal Remedy",
	art: sMendArt,
	class: classes.impulse,
	cost: 1,
	targets: targets.single_ally_self_inclusive,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.cure, 2]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_act]]
}

move_beam_data =
{
	name: "Beam",
	art: sBeamArt,
	class: classes.advent,
	cost: 2,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.energy_damage, 5]],
	self_effects: [[effects.status_effect, status_effects.energy_strengthened, 2]],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 12], [animation_act]]
}

move_zap_data =
{
	name: "Zap",
	art: sBeamArt,
	class: classes.element,
	cost: 3,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.energy_damage, 1], [effects.energy_damage, 2]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 12], [animation_act]]
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
	self_effects: [],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_venomous_stab_data =
{
	name: "Venomous Stab",
	art: sBiteArt,
	class: classes.penumbra,
	cost: 3,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 2], [effects.status_effect, status_effects.infected, 4]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_weakening_stab_data =
{
	name: "Weakening Stab",
	art: sBiteArt,
	class: classes.penumbra,
	cost: 3,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 2], [effects.status_effect, status_effects.physical_weakened, 3]],
	self_effects: [],
	restrictions: [],
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
	self_effects: [],
	restrictions: [],
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
	self_effects: [],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_chomp_chomp_data =
{
	name: "Chomp Chomp",
	art: sBiteArt,
	class: classes.impulse,
	cost: 5,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 5], [effects.physical_damage, 5]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_sunder_data =
{
	name: "Sunder",
	art: sExplodeArt,
	class: classes.null,
	cost: 1,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.energy_damage, 3]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_shatter_data =
{
	name: "Shatter",
	art: sExplodeArt,
	class: classes.null,
	cost: 2,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.physical_damage, 2], [effects.status_effect, status_effects.physical_vulnerable, 3]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 8], [animation_act]]
}

move_vitrify_data =
{
	name: "Vitrify",
	art: sExplodeArt,
	class: classes.null,
	cost: 2,
	targets: targets.self_only,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.heal, 10], [effects.status_effect, status_effects.physical_vulnerable, 3], [effects.status_effect, status_effects.energy_vulnerable, 3]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_act]]
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
	self_effects: [],
	restrictions: [],
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
	effects: [[effects.status_effect, status_effects.physical_bolstered, 3]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_act]]
}

move_recuperate_data =
{
	name: "Recuperate",
	art: sMendArt,
	class: classes.bulwark,
	cost: 1,
	targets: targets.self_only,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.heal,  6]],
	self_effects: [],
	restrictions: [[restrictions.backline]],
	animation: [[animation_act]]
}

move_grapple_data =
{
	name: "Grapple",
	art: sBeamArt,
	class: classes.advent,
	cost: 2,
	targets: targets.single_enemy,
	can_target_dead: false,
	phase: battle_phases.action,
	effects: [[effects.energy_damage, 3], [effects.charge]],
	self_effects: [],
	restrictions: [],
	animation: [[animation_spawn_projectile, sProjectile, 12], [animation_target_swap_charge, 6], [animation_act]]
}

var _filename = "daemon_moves.dae"

if (false)//file_exists(_filename))
{
	var _buffer = buffer_load(_filename);
	var _json = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	var _load_array = json_parse(_json);
	daemon_move_array = _load_array;
} else {
	array_push(daemon_move_array, move_move_data, move_quickswap_data, move_poke_data, move_claw_data, move_bite_data, move_mend_data, move_herbal_remedy_data, move_beam_data, move_zap_data, move_dark_stab_data, move_venomous_stab_data, move_weakening_stab_data, move_burst_data, move_omegabite_data, move_chomp_chomp_data, move_sunder_data, move_shatter_data, move_vitrify_data, move_clash_data, move_bolster_data, move_recuperate_data, move_grapple_data);
	//show_message(array_length(daemon_move_array));

	var _json = json_stringify(daemon_move_array);
	var _buffer = buffer_create(string_byte_length(_json) + 1, buffer_fixed, 1);

	buffer_write(_buffer, buffer_string, _json);
	buffer_save(_buffer, _filename);
	buffer_delete(_buffer);
}

//Populate species data
var comcat_data = {
	sprite: sComcat,
	name: "Comcat",
	hp: 20,
	initiative: 10,
	classes: [classes.impulse],
	starting_moves: [1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4],
	unlocked_moves: [[3, 5, 6], [14], []],
	hand_size: 5,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 2,
	energy_defense: 0
}

var caracara_data = {
	sprite: sCaracara,
	name: "Caracara",
	hp: 14,
	initiative: 15,
	classes: [classes.null],
	starting_moves: [15, 15, 15, 15, 15, 15, 15, 15, 15],
	unlocked_moves: [[16, 16], [], []],
	hand_size: 3,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 2,
	energy_defense: 0
}

var knightman_data = {
	sprite: sKnightman,
	name: "Knightman",
	hp: 20,
	initiative: 10,
	classes: [classes.bulwark],
	starting_moves: [18, 18, 18, 18, 18, 18, 18, 18, 18],
	unlocked_moves: [[19, 19], [20, 20], []],
	hand_size: 3,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 3,
	energy_defense: 0
}

var skull_data = {
	sprite: sSkull,
	name: "Skull",
	hp: 28,
	initiative: 5,
	classes: [classes.penumbra],
	starting_moves: [9, 9, 9, 9, 9, 9, 9, 9, 9],
	unlocked_moves: [[10, 10], [], []],
	hand_size: 3,
	physical_attack: 2,
	energy_attack: 1,
	physical_defense: 2,
	energy_defense: 0
}

var eyebot_data = {
	sprite: sEyebot,
	name: "Eyebot",
	hp: 16,
	initiative: 20,
	classes: [classes.advent],
	starting_moves: [7, 7, 7, 7, 7, 7, 7, 7, 7, 21, 21, 21],
	unlocked_moves: [[9, 9], [], []],
	hand_size: 4,
	physical_attack: 0,
	energy_attack: 3,
	physical_defense: 1,
	energy_defense: 1
}

var jouwel_data = {
	sprite: sJouwel,
	name: "Jouwel",
	hp: 16,
	initiative: 5,
	classes: [classes.element],
	starting_moves: [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8],
	unlocked_moves: [[9, 9], [], []],
	hand_size: 4,
	physical_attack: 0,
	energy_attack: 3,
	physical_defense: 3,
	energy_defense: 0
}
 
var _filename = "daemon_species.dae"

if (false)//file_exists(_filename))
{
	var _buffer = buffer_load(_filename);
	var _json = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	var _load_array = json_parse(_json);
	
	daemon_species_array = _load_array;
} else {
	array_push(daemon_species_array, comcat_data, caracara_data, knightman_data, skull_data, eyebot_data, jouwel_data);
	
	var _json = json_stringify(daemon_species_array);
	var _buffer = buffer_create(string_byte_length(_json) + 1, buffer_fixed, 1);

	buffer_write(_buffer, buffer_string, _json);
	buffer_save(_buffer, _filename);
	buffer_delete(_buffer);
}

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

room_goto(rIntro);

victory_cutscene = [];
defeat_cutscene = [[cutscene_dialogue, ["You were defeated..."]]];
overworld_flag = overworld_flags.none;
battle_type = battle_types.challenge;
deckbuilding_daemon = noone;

visited_rooms = [];