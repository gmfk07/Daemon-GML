function animate_move(move, user_daemon, target_daemon_array)
{
	if (can_use_move(user_daemon.position, move.restrictions))
	{
	    with (global.battle_animation_controller)
	    {
	        move_animation_card = instance_create_depth(room_width/2, room_height - 192, 0, oBattleMoveCard);
		    move_animation_card.move = move;
		    if (move_animation_card.move.class == classes.classless || move_animation_card.move.class == user_daemon.classes[0] || (array_length(user_daemon.classes) == 2 && move_animation_card.move.class == user_daemon.classes[1]))
		    {
		        move_animation_card.same_class = true;
		    }
		    var animation_data = move.animation;
	        
	        in_animation = true;
	        animation_index = 0;
	        animation = animation_data;
	        self.user_daemon = user_daemon;
	        self.target_daemon_array = target_daemon_array;
	        
	        perform_animation(animation_data[animation_index]);
	    }
	}
}

function perform_animation(data)
{
    switch (array_length(data))
    {
        case 1:
            script_execute(data[0]);
            break;
        case 2:
            script_execute(data[0], data[1]);
            break;
        case 3:
            script_execute(data[0], data[1], data[2]);
            break;
		case 4:
            script_execute(data[0], data[1], data[2], data[3]);
            break;
    }
}

function animation_spawn_projectile(projectile_sprite, projectile_speed)
{
    for (var i=0; i<array_length(target_daemon_array); i++)
	{
		num_ongoing_animations++;
		var projectile = instance_create_depth(user_daemon.x, user_daemon.y, 0, oProjectile);
		projectile.origin_daemon = user_daemon;
		projectile.target_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, target_daemon_array[i]);
		projectile.projectile_speed = projectile_speed;
		projectile.sprite_index = projectile_sprite;
	}
}

function animation_act()
{
    battle_daemon_act(user_daemon);
}

//Swaps with target[0]
function animation_swap_target(swap_speed)
{
	var target_daemon = ds_map_find_value(global.battle_controller.position_daemon_map, target_daemon_array[0]);

	//If we're swapping with ourselves, just count that as one animation
	global.battle_animation_controller.num_ongoing_animations ++;	
	if (target_daemon != user_daemon)
	{
		global.battle_animation_controller.num_ongoing_animations++;
	}
	
	user_daemon.animating = true;
	user_daemon.animation_target_x = target_daemon.x;
	user_daemon.animation_target_y = target_daemon.y;
	user_daemon.animation_move_speed = swap_speed;

	target_daemon.animating = true;
	target_daemon.animation_target_x = user_daemon.x;
	target_daemon.animation_target_y = user_daemon.y;
	target_daemon.animation_move_speed = swap_speed;
}

//Swaps with center daemon
function animation_swap_charge(swap_speed)
{
	var target_daemon = get_center_daemon_position(user_daemon.position);
	target_daemon = global.battle_controller.position_daemon_map[? target_daemon];

	//If we're swapping with ourselves, just count that as one animation
	global.battle_animation_controller.num_ongoing_animations ++;	
	if (target_daemon != user_daemon)
	{
		global.battle_animation_controller.num_ongoing_animations++;
	}
	
	user_daemon.animating = true;
	user_daemon.animation_target_x = target_daemon.x;
	user_daemon.animation_target_y = target_daemon.y;
	user_daemon.animation_move_speed = swap_speed;

	target_daemon.animating = true;
	target_daemon.animation_target_x = user_daemon.x;
	target_daemon.animation_target_y = user_daemon.y;
	target_daemon.animation_move_speed = swap_speed;
}

function animation_target_swap_charge(swap_speed)
{
	var target_daemon = global.battle_controller.position_daemon_map[? target_daemon_array[0]];
	
	//Make sure to get the right center daemon
	var center_daemon = get_center_daemon_position(target_daemon_array[0]);
	center_daemon = global.battle_controller.position_daemon_map[? center_daemon];

	//If we're swapping with ourselves, just count that as one animation
	global.battle_animation_controller.num_ongoing_animations ++;	
	if (target_daemon != center_daemon)
	{
		global.battle_animation_controller.num_ongoing_animations++;
	}
	
	center_daemon.animating = true;
	center_daemon.animation_target_x = target_daemon.x;
	center_daemon.animation_target_y = target_daemon.y;
	center_daemon.animation_move_speed = swap_speed;

	target_daemon.animating = true;
	target_daemon.animation_target_x = center_daemon.x;
	target_daemon.animation_target_y = center_daemon.y;
	target_daemon.animation_move_speed = swap_speed;
}