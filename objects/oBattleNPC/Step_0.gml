/// @description If detected player, enter battle
if (distance_to_point(oPlayer.x, oPlayer.y) <= detection_radius && !global.cutscene_controller.in_cutscene && !defeated)
{
	triggered_combat = true;
    start_cutscene(battle_cutscene);
}