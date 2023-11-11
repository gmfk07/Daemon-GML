/// @description Default cutscene and team
move_claw_data = global.data_controller.move_claw_data;

top_daemon = {
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
center_daemon = {
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
bottom_daemon = {
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

battle_cutscene = [[cutscene_dialogue, ["Hey!", "Let's battle!"]], [cutscene_wait, 1], [cutscene_dialogue, ["Let's go!"]], [cutscene_battle, top_daemon, center_daemon, bottom_daemon]];
defeated_cutscene = [[cutscene_dialogue, ["You beat me.", "Straight up."]]]
dialogue = ["You beat me.", "Straight up."]