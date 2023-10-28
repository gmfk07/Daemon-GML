/// @description Handle mouseover start
if (!is_moused_over && global.party_controller.selected_party_daemon == noone)
{
	is_moused_over = true;
	image_xscale *= SELECTED_IMAGE_SCALE;
	image_yscale *= SELECTED_IMAGE_SCALE;
}