#macro TEXT new TextAction
#macro CHOICE new ChoiceAction
#macro OPTION new OptionAction
#macro GOTO new GotoAction
#macro EVENTFLAG new SetEventFlag

function DialogueAction() constructor {
	act = function() { };
}

// Define new text to type out
function TextAction(_text) : DialogueAction() constructor {
	text = _text;

	act = function(textbox) {
		textbox.set_text(text);
	}
}

function ChoiceAction(_text) : DialogueAction() constructor {
	text = _text;
	
	options = [];
	for (var i=1; i < argument_count; i++)
	{
		array_push(options, argument[i]);
	}
	
	act = function(textbox) {
		textbox.set_text(text);
		textbox.options = options;
		textbox.option_count = array_length(options);
		textbox.current_option = 0;
	}
}

function OptionAction(_text, _topic): DialogueAction() constructor {
	text = _text;
	topic = _topic;
	
	act = function(textbox)
	{
		textbox.set_topic(topic);
	}
}

function GotoAction(_topic): DialogueAction() constructor {
	topic = _topic;
	
	act = function(textbox)
	{
		textbox.set_topic(topic);
	}
}

function SetEventFlag(_flag): DialogueAction() constructor {
	flag = _flag;
	
	act = function(textbox)
	{
		raise_event_flag(flag);
	}
}