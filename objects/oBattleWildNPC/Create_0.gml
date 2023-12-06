/// @description Default cutscene and team
move_claw_data = global.data_controller.move_claw_data;

top_daemon = {
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	unused_moves: [move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 2,
	energy_defense: 0
}
center_daemon = {
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	unused_moves: [move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 2,
	energy_defense: 0
}
bottom_daemon = {
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	unused_moves: [move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0,
	physical_defense: 2,
	energy_defense: 0
}

battle_cutscene = [[cutscene_battle, top_daemon, center_daemon, bottom_daemon, battle_types.wild]];