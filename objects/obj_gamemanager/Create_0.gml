/// @description Add the global variables and create some instances
instance_create_depth(0, 0, 0, obj_gamecamera);

global.border_enabled = false;
border_enable(true);

global.debug = true;
stats_init();

global.seconds = 0;
global.minutes = 0;
alarm[0] = room_speed;

music_init();

global.drawingSurface = -1;
global.flavor_sprites = false; // Flavors the monster sprites

currentSprite = spr_border_line;
nextSprite = -1;

currentSpriteAlpha = 1;
nextSpriteAlpha = 0;

borderXScale = 1;
borderYScale = 1;

screenXScale = borderXScale;
screenYScale = borderYScale;

screenXOffset = 0;
screenYOffset = 0;

borderEnabled = global.border_enabled;

global.lang_punctuation = [".", ",", "!", "?", ":", ";"];
global.lang_asterisk = "*";
global.lang_period = ".";
global.format = [];

global.languages = ds_list_create();
global.messages = ds_map_create();
localization_load("game");

global.playerX = 0;
global.playerY = 0;
global.soulX = room_width / 2;
global.soulY = room_height / 2;

global.boxplacement = 0;

global.boxplacement_x[0] = 32;
global.boxplacement_y[0] = 250;

global.boxplacement_x[1] = 602;
global.boxplacement_y[1] = 385;

global.monster = noone;

global.currentroom = room_empty;
global.currentsong = undefined;

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
#macro game_version "1.00"
#macro game_owner "Animelici804"

room_goto_next();