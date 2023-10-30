/// @description Default dialogue and team
dialogue = ["default dialogue"];

move_claw_data =
{
	name: "Claw",
	art: sClawArt,
	class: classes.impulse,
	cost: 1,
	targets: targets.single_enemy,
	phase: battle_phases.prep,
	effects: [[effects.physical_damage, 2]],
	projectile_sprite: sProjectile,
	projectile_speed: 10,
	user_to_target_move: false,
	user_to_target_speed: 0,
	target_to_user_move: false,
	target_to_user_speed: 0
}

top_daemon = {
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0
}
center_daemon = {
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0
}
bottom_daemon = {
	sprite: sComcat,
	name: "Comcat",
	hp: 10,
	initiative: 10,
	classes: [classes.impulse],
	moves: [move_claw_data, move_claw_data, move_claw_data],
	hand_size: 2,
	physical_attack: 2,
	energy_attack: 0
}