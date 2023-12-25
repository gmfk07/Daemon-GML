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
			start_cutscene(oPlayer.closest_interactable.cutscene)
		}
	}
}