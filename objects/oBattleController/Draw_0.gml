/// @description Draw UI
// You can write your code in this editor
draw_set_alpha(1);
draw_sprite(sPoints, points > 0 ? 0 : 1, 32, room_height - 160);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_font(fnt_point_cost);

draw_text(32*3, room_height - 32*4.5, points);

draw_sprite(sPhaseTracker, phase, room_width/2, room_height - 64);

for (var i=0; i < array_length(selected_targets); i++)
{
	var damage_array = calculate_total_effects_damage(selected_card.move.effects, selected_card.move.class, selected_daemon, selected_targets);
	var target_battle_daemon = ds_map_find_value(position_daemon_map, selected_targets[i]);
	
	var modifier = get_class_modifier(selected_card.move.class, target_battle_daemon.classes);
	var text_color;
	if (modifier > 1)
	{
		text_color = c_red;
	}
	else if (modifier < 1)
	{
		text_color = c_blue;
	}
	else
	{
		text_color = c_white;
	}
	
	
	draw_sprite_ext(sTarget, 0, target_battle_daemon.x, target_battle_daemon.y, 1 + 0.25*sin(current_time/500), 1 + 0.25*sin(current_time/500), target_theta, c_white, 1);
	
	if (is_attacking_effects(selected_card.move.effects))
	{
		draw_set_font(fnt_damage);
		draw_set_color(text_color);
		draw_text(target_battle_daemon.x, target_battle_daemon.y - 16, "-" + string(damage_array[i]));
	}
}

if (selected_card != noone && array_length(selected_card.move.self_effects) > 0)
{
	var damage_array = calculate_total_effects_damage(selected_card.move.self_effects, selected_card.move.class, selected_daemon, [selected_daemon.position]);
	
	var modifier = get_class_modifier(selected_card.move.class, selected_daemon.classes);
	var text_color;
	if (modifier > 1)
	{
		text_color = c_red;
	}
	else if (modifier < 1)
	{
		text_color = c_blue;
	}
	else
	{
		text_color = c_white;
	}
	
	
	if (damage_array[0] != 0)
	{
		draw_sprite_ext(sTarget, 0, selected_daemon.x, selected_daemon.y, 1 + 0.25*sin(current_time/500), 1 + 0.25*sin(current_time/500), target_theta, c_white, 1);
		if (is_attacking_effects(selected_card.move.self_effects))
		{
			draw_set_font(fnt_damage);
			draw_set_color(text_color);
			draw_text(selected_daemon.x, selected_daemon.y - 16, "-" + string(damage_array[0]));
		}
	}
}