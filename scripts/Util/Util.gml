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
	status_effect, //applies status effect, 2 param: status effect, turn duration
	cure, //removes stacks of negative status effect, 1 param: stacks
	charge, //sends the target to the front
	cancel //cancels the target's current move
}

enum restrictions
{
	backline,
	frontline
}

enum status_effects
{
	physical_vulnerable, //take additional physical damage
	physical_bolstered, //take less physical damage
	energy_vulnerable, //take additional physical damage
	energy_bolstered, //take less physical damage
	physical_strengthened, //deal additional physical damage
	physical_weakened, //deal less physical damage
	energy_strengthened, //deal additional energy damage
	energy_weakened, //deal less energy damage
	infected //take stacks worth of damage when acting
}

enum wild_behaviors
{
	idle, //stand still, 0 params
	wander, //wander around, 1 param: max_distance_wander
	wander_leashed //wander around within home area, 2 param: max_distance_wander_relative, max_distance_from_home
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
		case status_effects.physical_strengthened:
			return sIconPhysicalStrengthened;
		break;
		
		case status_effects.physical_weakened:
			return sIconPhysicalWeakened;
		break;
		
		case status_effects.physical_bolstered:
			return sIconPhysicalBolstered;
		break;
		
		case status_effects.physical_vulnerable:
			return sIconPhysicalVulnerable;
		break;
		
		case status_effects.energy_strengthened:
			return sIconEnergyStrengthened;
		break;
		
		case status_effects.energy_weakened:
			return sIconEnergyWeakened;
		break;
		
		case status_effects.energy_bolstered:
			return sIconEnergyBolstered;
		break;
		
		case status_effects.energy_vulnerable:
			return sIconEnergyVulnerable;
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
		case status_effects.physical_strengthened:
			return "Physical Strengthened";
		break;
		
		case status_effects.physical_weakened:
			return "Physical Weakened";
		break;
		
		case status_effects.physical_bolstered:
			return "Physical Bolstered";
		break;
		
		case status_effects.physical_vulnerable:
			return "Physical Vulnerable";
		break;
	
		case status_effects.energy_strengthened:
			return "Energy Strengthened";
		break;
	
		case status_effects.energy_weakened:
			return "Energy Weakened";
		break;
		
		case status_effects.energy_bolstered:
			return "Energy Bolstered";
		break;
	
		case status_effects.energy_vulnerable:
			return "Energy Vulnerable";
		break;
		
		case status_effects.infected:
			return "Infected";
		break;
	}
}

function get_status_effect_sprite_name(status_effect)
{
	switch (status_effect)
	{	
		case status_effects.physical_strengthened:
			return "/sIconPhysicalStrengthened";
		break;
		
		case status_effects.physical_weakened:
			return "/sIconPhysicalWeakened";
		break;
		
		case status_effects.physical_bolstered:
			return "/sIconPhysicalBolstered";
		break;
		
		case status_effects.physical_vulnerable:
			return "/sIconPhysicalVulnerable";
		break;
	
		case status_effects.energy_strengthened:
			return "/sIconEnergyStrengthened";
		break;
	
		case status_effects.energy_weakened:
			return "/sIconEnergyWeakened";
		break;
		
		case status_effects.energy_bolstered:
			return "/sIconEnergyBolstered";
		break;
	
		case status_effects.energy_vulnerable:
			return "/sIconEnergyVulnerable";
		break;
		
		case status_effects.infected:
			return "/sIconInfected";
		break;
	}
}

//Returns the opposite status effect that counters this one, or noone if none apply.
function get_status_effect_opposite(status_effect)
{
	switch (status_effect)
	{
		case status_effects.physical_strengthened:
			return status_effects.physical_weakened;
		break;
		
		case status_effects.physical_weakened:
			return status_effects.physical_strengthened;
		break;
		
		case status_effects.physical_bolstered:
			return status_effects.physical_vulnerable;
		break;
		
		case status_effects.physical_vulnerable:
			return status_effects.physical_bolstered;
		break;
		
		case status_effects.energy_strengthened:
			return status_effects.energy_weakened;
		break;
		
		case status_effects.energy_weakened:
			return status_effects.energy_strengthened;
		break;
		
		case status_effects.energy_bolstered:
			return status_effects.energy_vulnerable;
		break;
		
		case status_effects.energy_vulnerable:
			return status_effects.energy_bolstered;
		break;
	}
	return noone;
}

//Returns the center daemon position corresponding to a side of the battlefield given by position.
function get_center_daemon_position(position)
{
	if (position == positions.enemy_top || position == positions.enemy_center || position == positions.enemy_bottom)
	{
		return positions.enemy_center;
	}
	else
	{
		return positions.player_center;
	}
}

#macro SELECTED_IMAGE_SCALE 1.5
#macro ATTACK_OUTCLASS_DAMAGE_MULTIPLIER 1.5
#macro DEFENDER_OUTCLASS_DAMAGE_MULTIPLIER 0.5
#macro VULNERABLE_DAMAGE_MULTIPLIER 1.5
#macro STRENGTHENED_DAMAGE_MULTIPLIER 1.5
#macro BOLSTERED_DAMAGE_MULTIPLIER 0.5
#macro WEAKENED_DAMAGE_MULTIPLIER 0.5