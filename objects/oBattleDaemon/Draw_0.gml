/// @description Draw self and target lines
draw_set_alpha(1);
draw_set_color(c_white);

for (var i=0; i < array_length(selected_targets); i++)
{
	var targeted_battle_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, selected_targets[i]);
	draw_line(x, y, targeted_battle_daemon.x, targeted_battle_daemon.y);
}

draw_self();

var pc;
pc = (hp / max_hp) * 100;

draw_healthbar(x-sprite_width/2, y+sprite_height/2-16, x+sprite_width/2, y+sprite_height/2, pc, c_black, c_red, c_lime, 0, true, true);