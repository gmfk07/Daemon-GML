/// @description Default cutscene, team, and behavior
move_claw_data = global.data_controller.move_claw_data;

top_daemon = {
	index: 0,
	moves: get_all_unlocked_moves(0, 1),
	unused_moves: [],
	level: 1,
	xp: 0
}
center_daemon = {
	index: 0,
	moves: get_all_unlocked_moves(0, 1),
	unused_moves: [],
	level: 1,
	xp: 0
}
bottom_daemon = {
	index: 0,
	moves: get_all_unlocked_moves(0, 1),
	unused_moves: [],
	level: 1,
	xp: 0
}

battle_cutscene = [[cutscene_battle, top_daemon, center_daemon, bottom_daemon, battle_types.wild]];
behavior = [wild_behaviors.wander_leashed, 128, 512];

//All time in milliseconds
wander_time = random_range(min_wander_time, max_wander_time);
target_x = x;
target_y = y;
home_x = x;
home_y = y;

spawned_by = noone;