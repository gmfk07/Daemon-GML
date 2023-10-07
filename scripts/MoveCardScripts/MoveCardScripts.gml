function get_target_sprite(given_targets)
{
	switch (given_targets)
	{
		case targets.all_allies:
			return sAllAllies;
		break;
		
		case targets.all_enemies:
			return sSingleEnemy;
		break;
		
		case targets.single_ally_self_exclusive:
			return sSingleAllySelfExclusive;
		break;
		
		case targets.single_ally_self_inclusive:
			return sSingleAllySelfInclusive;
		break;
		
		case targets.single_enemy:
			return sSingleEnemy;
		break;
	}
}

function get_description_string(given_effects)
{
	var result = "";
	
	for (var i=0; i < array_length(given_effects); i++)
	{
		if (i > 0)
		{
			result += ", ";
		}
		
		var effect = given_effects[i]
		switch (effect[0])
		{
			case effects.physical_damage:
				result += "Phys Atk " + string(effect[1]);
			break;
			case effects.energy_damage:
				result += "Energy Atk " + string(effect[1]);
			break;
			case effects.heal:
				result += "Heal" + string(effect[1]);
			break;
			case effects.swap:
				result += "Swap";
			break;
		}
	}
	
	return result;
}

function get_card_shell_sprite_from_class(class)
{
	switch (class)
	{
		case classes.classless:
			return sCardShellClassless;
		break;
		
		case classes.advent:
			return sCardShellAdvent;
		break;
		
		case classes.bulwark:
			return sCardShellBulwark;
		break;
		
		case classes.element:
			return sCardShellElement;
		break;
		
		case classes.impulse:
			return sCardShellImpulse;
		break;
		
		case classes.null:
			return sCardShellNull;
		break;
		
		case classes.penumbra:
			return sCardShellPenumbra;
		break;
	}
}