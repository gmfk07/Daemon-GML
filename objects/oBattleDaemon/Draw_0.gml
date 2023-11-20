/// @description Draw self and target lines
draw_set_alpha(1);
draw_set_color(c_white);
draw_self();

if (hp > 0)
{
	for (var i=0; i < array_length(selected_targets); i++)
	{
		var targeted_battle_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, selected_targets[i]);
		draw_line(x, y, targeted_battle_daemon.x, targeted_battle_daemon.y);
	}
	var status_effect_count = ds_list_size(status_effect_list);
	
	for (var i=0; i < status_effect_count; i++)
	{
		draw_sprite(get_status_effect_icon(status_effect_list[| i].status_effect), 0, x + i*32 - (status_effect_count/2)*32, y-64);
		draw_set_font(fnt_turns_left);
		draw_text(x + i*32 - (status_effect_count/2)*32, y-64, status_effect_list[| i].duration);
	}
}

var pc;
pc = (hp / max_hp) * 100;

draw_healthbar(x-sprite_width/2, y+sprite_height/2-16, x+sprite_width/2, y+sprite_height/2, pc, c_black, c_red, c_lime, 0, true, true);