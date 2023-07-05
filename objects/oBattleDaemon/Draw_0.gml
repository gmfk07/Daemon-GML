/// @description Draw self and target lines
for (var i=0; i < array_length(selected_targets); i++)
{
	draw_line(x, y, selected_targets[i].x, selected_targets[i].y);
}

draw_self();

var pc;
pc = (hp / max_hp) * 100;

draw_healthbar(x-sprite_width/2, y+sprite_height/2-16, x+sprite_width/2, y+sprite_height/2, pc, c_black, c_red, c_lime, 0, true, true);