/// @description Follow
if (follow != noone)
{
	xTo = follow.x;
	yTo = follow.y;
}

x += (xTo - x)/25;
y += (yTo - y)/25

camera_set_view_pos(view_camera[0], x - cam_width*0.5, y - cam_height*0.5);