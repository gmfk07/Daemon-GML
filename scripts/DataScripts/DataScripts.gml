function get_daemon_data_from_position(position)
{
    return ds_map_find_value(global.data_controller.daemon_data_map, position);
}

function set_daemon_data_from_position(position, value)
{
    ds_map_set(global.data_controller.daemon_data_map, position, value);
}

//Given two non-reserve positions, swaps daemons.
function swap_daemon_data_from_positions(position1, position2)
{
    var temp_position1_data = ds_map_find_value(global.data_controller.daemon_data_map, position1);
    var temp_position2_data = ds_map_find_value(global.data_controller.daemon_data_map, position2);
    ds_map_set(global.data_controller.daemon_data_map, position1, temp_position2_data);
    ds_map_set(global.data_controller.daemon_data_map, position2, temp_position1_data);
}

//Given a non-reserve position and an index into the reserve list, swaps the two daemons.
function swap_daemon_data_from_position_with_reserve(position, reserve_index)
{
	var temp_position_data = global.data_controller.daemon_data_map[? position];
	var temp_reserve_data = global.data_controller.daemon_reserve_list[| reserve_index];
	ds_map_set(global.data_controller.daemon_data_map, position, temp_reserve_data);
	ds_list_set(global.data_controller.daemon_reserve_list, reserve_index, temp_position_data);
}

//Given two reserve indices, swaps daemons.
function swap_daemon_data_from_reserve_indices(reserve_index1, reserve_index2)
{
    var temp_reserve1_data = global.data_controller.daemon_reserve_list[| reserve_index1];
    var temp_reserve2_data = global.data_controller.daemon_reserve_list[| reserve_index2];
    ds_list_set(global.data_controller.daemon_reserve_list, reserve_index1, temp_reserve2_data);
    ds_list_set(global.data_controller.daemon_reserve_list, reserve_index2, temp_reserve1_data);
}

function set_victory_cutscene(cutscene)
{
	global.data_controller.victory_cutscene = cutscene;
}

function clear_victory_cutscene()
{
	global.data_controller.victory_cutscene = [];
}