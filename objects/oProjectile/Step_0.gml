/// @description Move towards target, destroy if reached
move_towards_point(target_daemon.x, target_daemon.y, projectile_speed);

if (point_distance(x, y, target_daemon.x, target_daemon.y) < projectile_speed)
{
	battle_daemon_act(origin_daemon);
	instance_destroy(self);
}