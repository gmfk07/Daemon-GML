sprite_index = sPlayer;
cutscene =  [
				[cutscene_dialogue, "Example1"],
				[cutscene_npc_change_sprite, 0, sBattleChallengeNPC],
				[cutscene_dialogue, "Example2"],
				[cutscene_branch_event_flag, "correct", [[cutscene_delete_closest_interactable]], []]
			];
npc_id = 0;