/// @description Handle timers, movement
switch (behavior[0])
{
	case wild_behaviors.wander:
		if (move_timer >= wander_time)
		{
			wander_time = current_time + random_range(min_wander_time, max_wander_time);

			do {
				target_x = random_range(x - behavior[1], x + behavior[1]);
				target_y = random_range(y - behavior[1], y + behavior[1]);
			}
			until (target_x >= 0 && target_x <= room_width
			&& target_y >= 0 && target_y <= room_height
			&& !collision_point(target_x, target_y, oWall, 0, 0))
		}
		
		move_timer = current_time;
		mp_potential_step_object(target_x, target_y, spd, oWall);
	break;
}