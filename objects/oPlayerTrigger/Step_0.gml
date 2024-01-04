/// @description Check if player within trigger zone
var player = instance_find(oPlayer, 0);

if (!triggered && collision_rectangle(x, y, x+width, y+height, oPlayer, 0, 0))
{
	triggered = true;
	start_cutscene(cutscene);
}