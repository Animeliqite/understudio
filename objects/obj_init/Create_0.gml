/// @description  Add the global variables and create some instances

instance_create(0, 0, input); // Create the input system

global.debug = true;
global.genocide = -1; // Genocide Counter

global.player_pos_x = 0;
global.player_pos_y = 0;

global.name = "CHARA";
global.lv = 1;
global.hp = 20;
global.maxhp = 20;
global.xp = 0;
global.gold = 0;

global.boxplacement = 0;

global.boxplacement_x[0] = 32;
global.boxplacement_y[0] = 250;

global.boxplacement_x[1] = 602;
global.boxplacement_y[1] = 385;

global.monster = noone;

global.currentroom = room_empty;
global.currentsong = undefined;

for (var i = 0; i < 7; i++;) {
    global.item[i] = 0;
}

global.geno_sprite = false;

global.cutscene = false;

global.spawn = -999;

