/// @description Handle input
if (keyboard_check_pressed(ord("E")))
{
	if (in_dialogue)
	{
		if (dialogue_index + 1 < array_length(dialogue))
		{
			dialogue_index++;
		}
		else
		{
			dialogue_index = 0;
			in_dialogue = false;
			goto_next_scene();
		}
	}
	else
	{
		if (oPlayer.near_dialogue)
		{
			if (!oPlayer.closest_interactable.open_party)
			{
				start_cutscene([[cutscene_dialogue, oPlayer.closest_interactable.dialogue]]);
			}
			else
			{
				start_cutscene([[cutscene_dialogue, oPlayer.closest_interactable.dialogue], [cutscene_party]]);
			}
		}
	}
}