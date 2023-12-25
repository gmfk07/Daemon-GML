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

enum battle_types
{
	challenge,
	wild
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
	all_enemies,
	self_only
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
	vulnerable, //take additional damage
	strengthened, //deal additional damage
	infected //take stacks worth of damage when acting
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
		
		case status_effects.strengthened:
			return sIconStrengthened;
		break;
		
		case status_effects.infected:
			return sIconInfected;
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
		
		case status_effects.strengthened:
			return "Strengthened";
		break;
		
		case status_effects.infected:
			return "Infected";
		break;
	}
}

#macro SELECTED_IMAGE_SCALE 1.5
#macro ATTACK_OUTCLASS_DAMAGE_MULTIPLIER 1.5
#macro DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER 0.5
#macro VULNERABLE_DAMAGE_MULTIPLIER 1.5
#macro STRENGTHENED_DAMAGE_MULTIPLIER 1.5