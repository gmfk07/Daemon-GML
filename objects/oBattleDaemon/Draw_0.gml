/// @description Draw self and target lines
for (var i=0; i < array_length(selected_targets); i++)
{
	draw_line(x, y, selected_targets[i].x, selected_targets[i].y);
}

draw_self();