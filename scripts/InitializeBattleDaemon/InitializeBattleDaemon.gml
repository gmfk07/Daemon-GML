function initialize_battle_daemon(obj, data, player_owned=false)
{
	obj.sprite_index = data.sprite;
	obj.maxhp = data.hp;
	obj.hp = data.hp;
	obj.name = data.name;
	obj.classes = data.classes;
	obj.moves = data.moves;
	obj.hand_size = data.hand_size;
	obj.player_owned = player_owned;
	
	if (!player_owned)
	{
		obj.image_xscale = -1;
	}
}