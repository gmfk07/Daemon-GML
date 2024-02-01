/// @description Start selecting card
if (!selected)
{
	selected = true;
	global.party_controller.selected_party_daemon = self;
	
	layer = layer_get_id("Selected");
	
	if (!is_moused_over)
	{
		is_moused_over = true;
		image_xscale *= SELECTED_IMAGE_SCALE;
		image_yscale *= SELECTED_IMAGE_SCALE;
	}
}