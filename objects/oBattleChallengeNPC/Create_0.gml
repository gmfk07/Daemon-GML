/// @description Default cutscene and team
move_claw_data = global.data_controller.move_claw_data;
move_burst_data = global.data_controller.move_burst_data;

top_daemon = {
	index: 0,
	moves: get_all_unlocked_moves(0, 2)
}
center_daemon = {
	index: 0,
	moves: get_all_unlocked_moves(0, 2)
}
bottom_daemon = {
	index: 0,
	moves: get_all_unlocked_moves(0, 2)
}

battle_cutscene = [[cutscene_dialogue, ["Hey!", "Let's battle!"]], [cutscene_wait, 1], [cutscene_dialogue, ["Let's go!"]], [cutscene_battle, top_daemon, center_daemon, bottom_daemon, battle_types.challenge]];
defeated_cutscene = [[cutscene_dialogue, ["You beat me.", "Straight up."]]]
dialogue = ["You beat me.", "Straight up."]