/// @description Draw target icons
// You can write your code in this editor
draw_sprite(sPoints, 0, 32, room_height - 160);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_font(fnt_point_cost);
draw_text(32*3, room_height - 32*4.5, points);
for (var i=0; i < array_length(selected_targets); i++)
{
	draw_sprite_ext(sTarget, 0, selected_targets[i].x, selected_targets[i].y, 1 + 0.25*sin(current_time/500), 1 + 0.25*sin(current_time/500), target_theta, c_white, 1);
}