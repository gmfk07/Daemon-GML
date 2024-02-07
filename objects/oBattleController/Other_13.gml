/// @description Handle catch button pressed
var position = get_catchable_daemon_position();
var data = get_daemon_data_from_position(position);
ds_list_add(global.data_controller.daemon_reserve_list, data);

global.data_controller.overworld_flag = overworld_flags.victory;
room_goto_previous();
if (global.cutscene_controller.in_cutscene)
{
	goto_next_scene();
}