function get_target_sprite(given_targets)
{
	switch (given_targets)
	{
		case targets.all_allies:
			return sAllAllies;
		break;
		
		case targets.all_enemies:
			return sAllEnemies;
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
		
		case targets.self_only:
			return sSelfOnly;
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
			case effects.status_effect:
				result += "Inflict " + get_status_effect_name(effect[1]) + " " + string(effect[2]);
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

function get_phase_sprite_from_battle_phase(battle_phase)
{
	switch (battle_phase)
	{
		case battle_phases.prep:
			return sPrep;
		break;
		
		case battle_phases.action:
			return sAction;
		break;
		
		case battle_phases.move:
			return sMove;
		break;
	}
}

function is_attacking_move(move_data)
{
	for (var i=0; i<array_length(move_data.effects); i++)
	{
		if (move_data.effects[i][0] == effects.physical_damage || move_data.effects[i][0] == effects.energy_damage)
		{
			return true;
		}
	}
	return false;
}