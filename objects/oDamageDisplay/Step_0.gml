/// @description Update counters, check if should expire
seconds_alive += delta_time / 1000000;

if (seconds_alive >= target_seconds_alive)
{
	global.battle_controller.num_ongoing_animations--;
	instance_destroy();
}