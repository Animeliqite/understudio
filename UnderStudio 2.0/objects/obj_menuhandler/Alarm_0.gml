/// @description Proceed to the next room

instance_destroy(cymbalFader);
global.playerName = namingName;
song_stop(menuMusic);
room_goto_next();