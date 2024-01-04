//Starts cutscene from cutscene_array, does nothing if data is an empty array
function start_cutscene(data)
{
	if (array_length(data) > 0)
	{
	    with (global.cutscene_controller)
	    {
	        scene_data = data;
	        in_cutscene = true;
	        scene_index = 0;
	    }
	}
}

//Goes to the next scene, or ends the cutscene if this was the last scene.
function goto_next_scene()
{
	with (global.dialogue_controller)
	{
		in_dialogue = false;
	}
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
		case 6:
            script_execute(data[0], data[1], data[2], data[3], data[4], data[5]);
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
    //We rely on oTextBox to call goto_next_scene()
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

function cutscene_npc_change_sprite(_npc_id, _sprite)
{
	var object = get_npc_from_npc_id(_npc_id)
	with (object)
	{
		sprite_index = _sprite;
	}
	goto_next_scene();
}

function cutscene_npc_move(_npc_id, _new_x, _new_y, _spd)
{
	var object = get_npc_from_npc_id(_npc_id)
	with (object)
	{
		if (point_distance(x, y, _new_x, _new_y) <= _spd)
		{
			x = _new_x;
			y = _new_y;
			speed = 0;
			goto_next_scene();
		}
		else
		{
			var _dir = point_direction(x, y, _new_x, _new_y)
			{
				var l_dir_x = lengthdir_x(_spd, _dir);
				var l_dir_y = lengthdir_y(_spd, _dir);
				
				x += l_dir_x;
				y += l_dir_y;
			}
		};
	}
}

function cutscene_create_npc(_object, _npc_id, _cutscene, _x, _y)
{
	var created = instance_create_layer(_x, _y, "Instances", _object);
	created.npc_id = _npc_id;
	created.cutscene = _cutscene;
	goto_next_scene();
}

//Meant to go at the end of cutscenes!
function cutscene_branch_event_flag(event_flag, cutscene_raised, cutscene_unraised)
{
	goto_next_scene();
	if (has_event_flag(event_flag))
	{
		start_cutscene(cutscene_raised);
	} else {
		start_cutscene(cutscene_unraised);
	}
}

function get_npc_from_npc_id(_npc_id)
{
	with (oDialogueNPC)
	{
		if (npc_id == _npc_id)
		{
			return self;
		}
	}
}