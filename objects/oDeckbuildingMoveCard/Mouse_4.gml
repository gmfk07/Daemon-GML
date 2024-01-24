/// @description Swap move / unused move
if (is_used)
{
	deckbuilding_transfer_move_to_unused_moves(index);
}
else
{
	deckbuilding_transfer_unused_move_to_moves(index);
	if (global.deckbuilding_controller.unused_index == index && index > 0)
	{
		global.deckbuilding_controller.unused_index--;
	}
}
delete_deckbuilding_cards();
create_deckbuilding_cards();