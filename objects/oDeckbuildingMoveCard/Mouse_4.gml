/// @description Swap move/unused move
if (is_used)
{
	deckbuilding_transfer_move_to_unused_moves(index);
}
else
{
	deckbuilding_transfer_unused_move_to_moves(index);
}
room_restart();