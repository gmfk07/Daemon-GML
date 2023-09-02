enum battle_phases
{
	selecting,
	move,
	prep,
	action
}

enum positions
{
	enemy_top,
	enemy_center,
	enemy_bottom,
	player_top,
	player_center,
	player_bottom
}

enum classes
{
	bulwark,
	element,
	impulse,
	penumbra,
	null,
	advent,
	classless
}

enum targets
{
	single_ally_self_inclusive,
	single_ally_self_exclusive,
	single_enemy,
	all_allies,
	all_enemies
}

enum attack_types
{
	physical,
	energy,
	none
}

enum effects
{
	swap //swaps user and target positions, expected to be used w/ 1 target
}

#macro SELECTED_IMAGE_SCALE 1.5