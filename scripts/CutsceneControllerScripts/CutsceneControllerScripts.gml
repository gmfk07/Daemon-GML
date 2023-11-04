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

function cutscene_battle()
{
    room_goto(rBattle);
    goto_next_scene();
}