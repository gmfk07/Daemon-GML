/// @description Handle scrolling

if (mouse_wheel_up())
{
	unused_index = min(unused_index + 1, array_length(unused_moves) - 1);
	delete_deckbuilding_cards();
	create_deckbuilding_cards();
}

if (mouse_wheel_down())
{
	unused_index = max(unused_index - 1, 0);
	delete_deckbuilding_cards();
	create_deckbuilding_cards();
}