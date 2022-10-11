/// @description Proceed to the next room

instance_destroy(cymbalFader);
global.playerName = namingName;
song_stop(musicFile);
room_goto_next();