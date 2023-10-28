/// @description Handle card mouseover end
if (is_moused_over)
{
	is_moused_over = false;
	image_xscale /= SELECTED_IMAGE_SCALE;
	image_yscale /= SELECTED_IMAGE_SCALE;
}