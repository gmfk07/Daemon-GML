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

function get_class_strengths(class)
{
	switch (class)
	{
		case classes.advent:
			return [classes.impulse];
		break;
			
		case classes.bulwark:
			return [classes.advent, classes.element];
		break;
		
		case classes.element:
			return [classes.impulse, classes.penumbra];
		break;
		
		case classes.impulse:
			return [classes.bulwark, classes.null];
		break;
		
		case classes.null:
			return [classes.element];
		break;
		
		case classes.penumbra:
			return [classes.bulwark];
		break;
	}
}

function get_class_weaknesses()
{
	switch (class)
	{
		case classes.advent:
			return [classes.bulwark];
		break;
			
		case classes.bulwark:
			return [classes.penumbra, classes.impulse];
		break;
		
		case classes.element:
			return [classes.null, classes.bulwark];
		break;
		
		case classes.impulse:
			return [classes.element, classes.advent];
		break;
		
		case classes.null:
			return [classes.impulse];
		break;
		
		case classes.penumbra:
			return [classes.element];
		break;
	}
}

#macro SELECTED_IMAGE_SCALE 1.5