/// @description Draw self and stats
draw_self();
if (position != positions.reserve)
{
	draw_set_font(fnt_dialogue);
	draw_set_halign(fa_left);
	draw_set_color(c_black);
	var data = get_daemon_data_from_position(position);
	var species_data = get_species_data(data.index);
	draw_text_ext(x + 128, y - 64, species_data.name + " Lv " + string(data.level) + " Xp " + string(data.experience) + " " + string(species_data.classes) + "\nHP " + string(species_data.hp) + " Hand Size " + string(species_data.hand_size) + " PAtk " + string(species_data.physical_attack) + " PDef " + string(species_data.physical_defense) + " EAtk " + string(species_data.energy_attack) + " EDef " + string(species_data.energy_defense) + " Init " + string(species_data.initiative), 32, room_width*2/3);
}