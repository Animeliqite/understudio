/// @description Add the global variables and create some instances
instance_create_depth(0, 0, 0, obj_gamecamera);

global.border_enabled = false;
border_enable(true);

global.debug = true;
stats_init();

global.seconds = 0;
global.minutes = 0;
alarm[0] = room_speed;

other_init();
music_init();

global.drawingSurface = -1;
global.soulColor = c_red;
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
localization_init();
//localization_load("example");

global.playerX = 0;
global.playerY = 0;
global.soulX = room_width / 2;
global.soulY = room_height / 2;

global.board = 0;
global.boardX1 = 32;
global.boardY1 = 250;
global.boardX2 = 602;
global.boardY2 = 385;

global.battleSettings = ds_map_create();

global.currentroom = room_empty;
global.currentsong = undefined;

global.cutscene = false;
global.spawn = -999;

global.currentsave = 0;

bt_set([obj_battlemonster_parent]);

if file_exists("crash.txt")
	room_goto(room_crash);
else
	room_goto_next();