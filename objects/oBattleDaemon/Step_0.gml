/// @description Animate
if (animating)
{
	if (point_distance(x, y, animation_target_x, animation_target_y) < animation_move_speed)
	{
		x = animation_target_x;
		y = animation_target_y;
			
		animating = false;
		global.battle_controller.num_ongoing_animations--;
		
		speed = 0;
		
		if (animation_trigger_act_on_end)
		{
			battle_daemon_act(self);
			animation_trigger_act_on_end = false;
		}
	}
	else
	{
		move_towards_point(animation_target_x, animation_target_y, animation_move_speed);
	}
}

if (hp <= 0)
{
	image_blend = c_dkgray;
}