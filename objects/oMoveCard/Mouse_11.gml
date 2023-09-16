/// @description Handle card mouseover end
if (global.battle_controller.selected_card == noone)
{
	is_moused_over = false;
	image_scale /= SELECTED_IMAGE_SCALE;
}