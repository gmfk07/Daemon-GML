/// @description Draw target icons
// You can write your code in this editor
draw_set_alpha(1);
draw_sprite(sPoints, points > 0 ? 0 : 1, 32, room_height - 160);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_font(fnt_point_cost);

draw_text(32*3, room_height - 32*4.5, points);

for (var i=0; i < array_length(selected_targets); i++)
{
	var damage_array = calculate_total_move_damage(selected_card.move, selected_daemon, selected_targets);
	var target_battle_daemon = ds_map_find_value(position_daemon_map, selected_targets[i]);
	draw_sprite_ext(sTarget, 0, target_battle_daemon.x, target_battle_daemon.y, 1 + 0.25*sin(current_time/500), 1 + 0.25*sin(current_time/500), target_theta, c_white, 1);
	draw_set_font(fnt_damage);
	draw_text(target_battle_daemon.x, target_battle_daemon.y - 16, "-" + string(damage_array[i]));
}