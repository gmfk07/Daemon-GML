/// @description Init vars
confirm_key = ord("E");
up_key = ord("W");
down_key = ord("S");

max_input_delay = 3;
input_delay = max_input_delay;

//Pos
width = display_get_gui_width() - margin*2;
height = sprite_height*5;

x = (display_get_gui_width() - width)/2
y = display_get_gui_height() - height - margin;

//Text
text_font = fnt_dialogue;
text_color = c_black;
text_speed = 0.6;
text_x = padding;
text_y = padding;
text_width = width - padding * 2;

//Options
option_x = padding;
option_y = -padding * 2;
option_spacing = 50;
option_selection_indent = 40;
option_width = 300;
option_height = 40;
option_text_x = 16;
option_text_color = c_black;

/// Private variables
actions = []
current_action = -1;

options = []
current_option = 0;
option_count = 0;

text = ""
text_index = 0;
text_length = 0;

finished = false;

/// Methods

set_topic = function(topic) {
	actions = global.topics[$ topic];
	current_action = -1;
	
	next();
}

next = function() {
	current_action++;
	if (current_action >= array_length(actions)) {
		instance_destroy();
		goto_next_scene();
	}
	else
	{
		actions[current_action].act(id);
	}
}

set_text = function(newText) {
	text = newText;
	text_length = string_length(newText);
	text_index = 0;
}