enum battle_phases
{
	selecting = 0,
	prep = 1,
	action = 2,
	move = 3
}

enum overworld_flags
{
	none,
	defeat,
	victory
}

enum positions
{
	enemy_top,
	enemy_center,
	enemy_bottom,
	player_top,
	player_center,
	player_bottom,
	reserve
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
	swap, //swaps user and target positions, expected to be used w/ 1 target, 0 params
	physical_damage, //deals physical damage, 1 param: damage
	energy_damage, //deals energy damage, 1 param: damage
	heal, //heals, 1 param: healing
	status_effect //applies status effect, 2 param: status effect, turn duration
}

enum status_effects
{
	vulnerable
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

function get_class_weaknesses(class)
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

function get_status_effect_icon(status_effect)
{
	switch (status_effect)
	{
		case status_effects.vulnerable:
			return sIconVulnerable;
		break;
	}
}

function get_status_effect_name(status_effect)
{
	switch (status_effect)
	{
		case status_effects.vulnerable:
			return "Vulnerable";
		break;
	}
}

#macro SELECTED_IMAGE_SCALE 1.5
#macro ATTACK_OUTCLASS_DAMAGE_MULTIPLIER 1.5
#macro DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER 0.5
#macro VULNERABLE_DAMAGE_MULTIPLIER 1.5