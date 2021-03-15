/// @description  Add the global variables and create some instances

instance_create(0, 0, input); // Create the input system

global.border_enabled = false;
instance_create(0, 0, obj_border); // Create the border system
border_enable(true);

global.messages = ds_map_create();
localization_init("data/game.json");

global.debug = true;
stats_init();

global.seconds = 0;
global.minutes = 0;
alarm[0] = room_speed;

if (!file_exists("secret")) {
	global.key = generate_key();
	ini_open_encrypted_zlib("secret", "VeryVerySecret");
	ini_write_string("SaveData", "AES", global.key);
	ini_close_encrypted_zlib("secret", "VeryVerySecret");
}
else {
	ini_open_encrypted_zlib("secret", "VeryVerySecret");
	global.key = ini_read_string("SaveData", "AES", "");
	show_debug_message(global.key);
	ini_close();
}

global.player_pos_x = 0;
global.player_pos_y = 0;

global.soul_pos_x = room_width / 2;
global.soul_pos_y = room_height / 2;

global.boxplacement = 0;

global.boxplacement_x[0] = 32;
global.boxplacement_y[0] = 250;

global.boxplacement_x[1] = 602;
global.boxplacement_y[1] = 385;

global.monster = noone;

global.currentroom = room_empty;
global.currentsong = undefined;

global.geno_sprite = false;

global.cutscene = false;
global.spawn = -999;

global.currentsave = 0;

enum text_effect {
	none,
	shake,
	partly_shake,
	wave
}

#macro game_savename "undertale_engine"
#macro game_name "Undertale Engine"
#macro game_owner "Animelici804"
