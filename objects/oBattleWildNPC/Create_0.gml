/// @description Default cutscene and team
move_claw_data = global.data_controller.move_claw_data;

top_daemon = {
	index: 0,
	moves: [move_claw_data, move_claw_data, move_claw_data],
	unused_moves: [move_claw_data],
}
center_daemon = {
	index: 0,
	moves: [move_claw_data, move_claw_data, move_claw_data],
	unused_moves: [move_claw_data],
}
bottom_daemon = {
	index: 0,
	moves: [move_claw_data, move_claw_data, move_claw_data],
	unused_moves: [move_claw_data],
}

battle_cutscene = [[cutscene_battle, top_daemon, center_daemon, bottom_daemon, battle_types.wild]];