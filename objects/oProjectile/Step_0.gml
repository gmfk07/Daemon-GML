/// @description Move towards target, destroy if reached
move_towards_point(target_daemon.x, target_daemon.y, projectile_speed);

if (point_distance(x, y, target_daemon.x, target_daemon.y) < projectile_speed)
{
	global.battle_animation_controller.num_ongoing_animations--;
	instance_destroy(self);
}