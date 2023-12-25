/// @description Movement and near_dialogue check

if (!global.cutscene_controller.in_cutscene)
{
	//Movement
	var moving_up = (keyboard_check(ord("W")) || keyboard_check(vk_up));
	var moving_down = (keyboard_check(ord("S")) || keyboard_check(vk_down));
	var moving_left = (keyboard_check(ord("A")) || keyboard_check(vk_left));
	var moving_right = (keyboard_check(ord("D")) || keyboard_check(vk_right));

	var h_movement = (moving_right - moving_left) * movement_speed;
	var v_movement = (moving_down - moving_up) * movement_speed;

	var angle = point_direction(0, 0, h_movement, v_movement);
	var delta_x = lengthdir_x(movement_speed, angle) * abs(h_movement);
	var delta_y = lengthdir_y(movement_speed, angle) * abs(v_movement);

	if (place_meeting(x+delta_x, y, oSolid))
	{
		while (!place_meeting(x + sign(delta_x), y, oSolid))
		{
			x += sign(delta_x);
		}
		delta_x = 0;
	}

	x += delta_x;

	if (place_meeting(x, y+delta_y, oSolid))
	{
		while (!place_meeting(x, y + sign(delta_y), oSolid))
		{
			y += sign(delta_y);
		}
		delta_y = 0;
	}

	y += delta_y;
}

if (keyboard_check_pressed(ord("B")))
{
	room_goto(rBattle);
}

if (keyboard_check_pressed(vk_tab))
{
	if (!global.cutscene_controller.in_cutscene)
	{
		room_goto(rParty);
	}
}

closest_interactable = instance_nearest(x, y, oDialogueNPC);
if (closest_interactable == noone)
{
	near_dialogue = false;
} else {
	near_dialogue = point_distance(x, y, closest_interactable.x+16, closest_interactable.y+16) <= min_interact_distance;
}