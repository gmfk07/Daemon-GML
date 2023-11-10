/// @description If detected player, enter battle
if (distance_to_point(oPlayer.x, oPlayer.y) <= detection_radius && !global.cutscene_controller.in_cutscene)
{
	triggered_combat = true;
    start_cutscene([ [cutscene_dialogue, ["Hey!", "Let's battle!"]], [cutscene_wait, 1], [cutscene_dialogue, ["Let's go!"]], [cutscene_battle, top_daemon, center_daemon, bottom_daemon] ]);
}