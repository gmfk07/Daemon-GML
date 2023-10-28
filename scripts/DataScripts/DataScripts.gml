function get_daemon_data_from_position(position)
{
    return ds_map_find_value(global.data_controller.daemon_data_map, position);
}

function swap_daemon_data_from_positions(position1, position2)
{
    var temp_position1_data = ds_map_find_value(global.data_controller.daemon_data_map, position1);
    var temp_position2_data = ds_map_find_value(global.data_controller.daemon_data_map, position2);
    ds_map_set(global.data_controller.daemon_data_map, position1, temp_position2_data);
    ds_map_set(global.data_controller.daemon_data_map, position2, temp_position1_data);
}