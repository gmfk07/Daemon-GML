/// @description Selected daemon released
if (selected_party_daemon && selected_swap_daemon)
{
	//Swapping two in-party daemons
	if (selected_party_daemon.position != positions.reserve && selected_swap_daemon.position != positions.reserve)
	{
    	swap_daemon_data_from_positions(selected_party_daemon.position, selected_swap_daemon.position);
	}
	//Swapping reserve daemon with in-party daemon
	else if (selected_party_daemon.position == positions.reserve && selected_swap_daemon.position != positions.reserve)
	{
		swap_daemon_data_from_position_with_reserve(selected_swap_daemon.position, selected_party_daemon.reserve_index);
	}
	//Swapping in-party daemon with reserve daemon
	else if (selected_party_daemon.position != positions.reserve && selected_swap_daemon.position == positions.reserve)
	{
		swap_daemon_data_from_position_with_reserve(selected_party_daemon.position, selected_swap_daemon.reserve_index);
	}
	//Swapping two reserve daemons
	else if (selected_party_daemon.position == positions.reserve && selected_swap_daemon.position == positions.reserve)
	{
		swap_daemon_data_from_reserve_indices(selected_party_daemon.reserve_index, selected_swap_daemon.reserve_index);
	}
	
	room_restart();
}
selected_party_daemon = noone;
selected_swap_daemon = noone;