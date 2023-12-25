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

function clear_reserves()
{
	ds_list_clear(global.data_controller.daemon_reserve_list);
}

function set_victory_cutscene(cutscene)
{
	global.data_controller.victory_cutscene = cutscene;
}

function clear_victory_cutscene()
{
	global.data_controller.victory_cutscene = [];
}

function start_deckbuilding(daemon_data)
{
	global.data_controller.deckbuilding_daemon = daemon_data;
	room_goto(rDeckbuilding);
}

function deckbuilding_transfer_unused_move_to_moves(index)
{
	var move = global.data_controller.deckbuilding_daemon.unused_moves[index];
	array_delete(global.data_controller.deckbuilding_daemon.unused_moves, index, 1);
	array_push(global.data_controller.deckbuilding_daemon.moves, move);
}

function deckbuilding_transfer_move_to_unused_moves(index)
{
	var move = global.data_controller.deckbuilding_daemon.moves[index];
	array_delete(global.data_controller.deckbuilding_daemon.moves, index, 1);
	array_push(global.data_controller.deckbuilding_daemon.unused_moves, move);
}

function get_species_data(index)
{
	return global.data_controller.daemon_species_list[| index];
}

function handle_experience_gain(xp)
{
	var top_daemon = global.data_controller.daemon_data_map[? positions.player_top];
	top_daemon.experience += xp;
	while (top_daemon.experience >= top_daemon.level)
	{
		top_daemon.experience -= top_daemon.level;
		top_daemon.level++;
		//Add new cards to unused moves
		top_daemon.unused_moves = array_concat(top_daemon.unused_moves, global.data_controller.daemon_species_list[|top_daemon.index].unlocked_moves[top_daemon.level-2]);
	}
	
	var center_daemon = global.data_controller.daemon_data_map[? positions.player_center];
	center_daemon.experience += xp;
	while (center_daemon.experience >= center_daemon.level)
	{
		center_daemon.experience -= center_daemon.level;
		center_daemon.level++;
		//Add new cards to unused moves
		center_daemon.unused_moves = array_concat(center_daemon.unused_moves, global.data_controller.daemon_species_list[|center_daemon.index].unlocked_moves[center_daemon.level-2]);
	}
	
	var bottom_daemon = global.data_controller.daemon_data_map[? positions.player_bottom];
	bottom_daemon.experience += xp;
	while (bottom_daemon.experience >= bottom_daemon.level)
	{
		bottom_daemon.experience -= bottom_daemon.level;
		bottom_daemon.level++;
		//Add new cards to unused moves
		bottom_daemon.unused_moves = array_concat(bottom_daemon.unused_moves, global.data_controller.daemon_species_list[|bottom_daemon.index].unlocked_moves[bottom_daemon.level-2]);
	}
}

function get_all_unlocked_moves(index, level)
{
	var moves = global.data_controller.daemon_species_list[|index].starting_moves;
	for (var i=0; i<level-1; i++)
	{
		moves = array_concat(moves, global.data_controller.daemon_species_list[|index].unlocked_moves[i]);
	}
	return moves;
}