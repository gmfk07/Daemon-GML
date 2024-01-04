width = 128;
height = 128;
cutscene = [
			[cutscene_create_npc, oDialogueNPC, 42, [[cutscene_dialogue, "Welcome"]], 696, 288],
			[cutscene_npc_change_sprite, 42, sPlayer],
			[cutscene_dialogue, "Welcome"],
			[cutscene_npc_move, 42, 364, 288, 4]
			];