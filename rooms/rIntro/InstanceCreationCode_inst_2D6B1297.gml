top_daemon = {
	index: 0,
	moves: []
}
center_daemon = {
	index: 0,
	moves: []
}
bottom_daemon = {
	index: 0,
	moves: []
}
width = 128;
height = 128;
cutscene = [
			[cutscene_create_npc, oDialogueNPC, 42, [[cutscene_dialogue, "Post-welcome"]], 1390, y],
			[cutscene_npc_change_sprite, 42, sPlayer],
			[cutscene_dialogue, "Hey there"],
			[cutscene_npc_move, 42, 364, y, 12],
			[cutscene_dialogue, "Welcome"],
			[cutscene_party],
			[cutscene_dialogue, "Welcome 2"],
			[cutscene_battle, top_daemon, center_daemon, bottom_daemon],
			[cutscene_dialogue, "Battle explanation"],
			[cutscene_wait_for_battle_end],
			[cutscene_npc_move, 42, 1390, y, 12]
			];