/// @description  Add the global variables and create some instances

global.border_enabled = false;

instance_create(0, 0, input); // Create the input system
instance_create(0, 0, obj_border); // Create the border system
border_enable(true);

global.messages = ds_map_create();
localization_init("data/game.json");

global.debug = true;
global.genocide = -1; // Genocide Counter

stats_init();

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