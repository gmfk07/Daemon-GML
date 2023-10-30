/// @description If detected player, enter battle
if (distance_to_point(oPlayer.x, oPlayer.y) <= detection_radius)
{
    set_daemon_data_from_position(positions.enemy_top, top_daemon);
    set_daemon_data_from_position(positions.enemy_center, center_daemon);
    set_daemon_data_from_position(positions.enemy_bottom, bottom_daemon);
    
    start_cutscene([ [cutscene_dialogue, ["Hey!", "Let's battle!"]], [cutscene_wait, 1], [cutscene_dialogue, ["Let's go!"]] ]);
}