/// @description Handle card mouseover start
if (!selected && global.battle_controller.selected_card == noone)
{
	image_xscale *= SELECTED_IMAGE_SCALE;
	image_yscale *= SELECTED_IMAGE_SCALE;
}