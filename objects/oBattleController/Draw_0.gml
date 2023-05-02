/// @description Draw target icons
// You can write your code in this editor
for (var i=0; i < array_length(selected_targets); i++)
{
	draw_sprite_ext(sTarget, 0, selected_targets[i].x, selected_targets[i].y, 1, 1, target_theta, c_white, 1);
}