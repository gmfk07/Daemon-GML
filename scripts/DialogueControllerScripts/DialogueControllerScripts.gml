function start_dialogue(data)
{
    with (global.dialogue_controller)
    {
        dialogue = data;
		dialogue_index = 0;
		in_dialogue = true;
    }
}