game_fade(c_black, -1, 0, room_speed / 2);
file_delete(game_savename);
stats_init();

if (tempName != "")
	global.name = tempName;

room_goto_next();