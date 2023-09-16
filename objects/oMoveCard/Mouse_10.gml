/// @description Handle card mouseover start
if (!selected && global.battle_controller.selected_card == noone)
{
	is_moused_over = true;
	image_scale *= SELECTED_IMAGE_SCALE;
}