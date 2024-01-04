width = 128;
height = 128;
cutscene = [
			[cutscene_create_npc, oDialogueNPC, 42, [[cutscene_dialogue, "Welcome"]], 1390, 288],
			[cutscene_npc_change_sprite, 42, sPlayer],
			[cutscene_dialogue, "Hey there"],
			[cutscene_npc_move, 42, 364, 288, 6],
			[cutscene_dialogue, "Welcome"],
			[cutscene_party],
			[cutscene_dialogue, "Welcome 2"],
			[cutscene_npc_move, 42, 1390, 288, 6]
			];