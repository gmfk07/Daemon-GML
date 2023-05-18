/// @description Handle card released
for (var i=0; i < array_length(selected_targets); i++)
{
	with (selected_daemon)
	{
		selected_targets = other.selected_targets;
		
		if (selected_targets == [])
		{
			image_blend = c_white;
		}
		else
		{
			image_blend = c_dkgray;
		}
	}
}

clear_selected_daemon();