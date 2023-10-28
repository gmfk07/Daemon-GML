/// @description Selected daemon released
if (selected_party_daemon && selected_swap_daemon)
{
    swap_daemon_data_from_positions(selected_party_daemon.position, selected_swap_daemon.position);
    room_restart();
}
selected_party_daemon = noone;
selected_swap_daemon = noone;