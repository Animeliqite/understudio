game_fade(c_black, 1, 0, room_speed / 2);
file_delete(game_savename);
stats_init();
global.name = tempName;

room_goto_next();
//instance_destroy(obj_fader);