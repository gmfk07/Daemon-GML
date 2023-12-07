/// @description Handle selection, sprite

//If selected, snap to mouse
if (selected)
{
	x = mouse_x;
	y = mouse_y;
}

var species_data = get_species_data(data.index);
sprite_index = species_data.sprite;