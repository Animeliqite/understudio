/// @description Set up the variables

// Main variables
cooldown = 0;
menuno = 0;
stateSelection = 0;

// Button variables
buttonColor = [make_color_rgb(255, 127, 39), make_color_rgb(255, 225, 0), make_color_rgb(255, 225, 64)];
buttonCount = 3;
buttonIndex = 0;

// Monster variables
monsters     = bt_getsettings("monsters");
monsterHP    = [1];
monsterHPMax = [1];
monsterNames = ["Error"];
monsterActs  = ["Check"];
monsterStats = [[0, 0]]; // [ATK, DEF] Complicated, but works
monsterRewards = [[0, 0]]; // [EXP, GOLD] Complicated, but works
monsterIndex = 0;
monsterSpareable = [true];
monsterSpared = [false];
battleFleeable = bt_getsettings("fleeable");
fleeing = false;

// Submenu index variables
fightIndex = 0;
actIndex = 0;
itemIndex = 0;
mercyIndex = 0;

backgroundIndex = bt_getsettings("background");

// Message variables
wroteIntroMessage = false;
battleMessages = [["* Test Monster and its cohorts&  drew near."], [["Check"], ["Check"], ["Check"]], [[""], [""], [""]]]; // [Menu Messages, ACT Options, ACT Messages] Complicated, but works.
battleMessageFormat = [];

// Music variables
battleMusic = bt_getsettings("music");
battlePitch = 1;
battleVolume = 1;

// Board variables
boardX1 = global.boardX1;
boardY1 = global.boardY1;
boardX2 = global.boardX2;
boardY2 = global.boardY2;

// Turn variables
turnTime = 0;
transformReady = false;

// Other variables
obj_gamecamera.target = noone;
obj_gamecamera.xScale = 1;
obj_gamecamera.yScale = 1;
actWriters = [-1, -1, -1, -1, -1, -1];

depth = depth_battle.ui_low;