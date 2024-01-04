/// @description Handle input
if (keyboard_check_pressed(ord("E")))
{
	if (!global.cutscene_controller.in_cutscene)
	{
		if (oPlayer.near_dialogue)
		{
			start_cutscene(oPlayer.closest_interactable.cutscene);
		}
	}
}