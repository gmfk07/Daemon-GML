sprite_index = sPlayer;
cutscene =  [
				[cutscene_dialogue, "Example1"],
				[cutscene_change_sprite, self, sBattleChallengeNPC],
				[cutscene_dialogue, "Example2"],
				[cutscene_delete_closest_interactable]
			];