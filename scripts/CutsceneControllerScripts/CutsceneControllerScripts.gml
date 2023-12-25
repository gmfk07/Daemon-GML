function start_cutscene(data)
{
    with (global.cutscene_controller)
    {
        scene_data = data;
        in_cutscene = true;
        scene_index = 0;
    }
}

//Goes to the next scene, or ends the cutscene if this was the last scene.
function goto_next_scene()
{
    with (global.cutscene_controller)
    {
        if (array_length(scene_data) > scene_index+1)
        {
            scene_index++;
        }
        else
        {
            end_cutscene();
        }
    }
}

function end_cutscene()
{
    with (global.cutscene_controller)
    {
        in_cutscene = false;
    }
}

//Function called every step of the cutscene that executes the correct cutscene function.
function execute_scene(data)
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
        case 5:
            script_execute(data[0], data[1], data[2], data[3], data[4]);
            break;
    }
}

// Various cutscene function
function cutscene_wait(seconds)
{
    timer++;
    
    if (timer > seconds * room_speed)
    {
        timer = 0;
        goto_next_scene();
    }
}

function cutscene_dialogue(dialogue)
{
	if (!global.dialogue_controller.in_dialogue)
	{
		start_dialogue(dialogue);
	}
    //We rely on dialogue controller to call goto_next_scene()
}

function cutscene_battle(top_daemon, center_daemon, bottom_daemon, battle_type)
{
	set_daemon_data_from_position(positions.enemy_top, top_daemon);
    set_daemon_data_from_position(positions.enemy_center, center_daemon);
    set_daemon_data_from_position(positions.enemy_bottom, bottom_daemon);
    global.data_controller.battle_type = battle_type;
    room_goto(rBattle);
    goto_next_scene();
}

function cutscene_party()
{
	if (room != rParty)
	{
		room_goto(rParty);
	}
	global.data_controller.selecting_starters = true;
	//We rely on party controller to call goto_next_scene()
}

function cutscene_delete_closest_interactable()
{
	with (oPlayer.closest_interactable)
	{
		instance_destroy();
	}
	goto_next_scene();
}