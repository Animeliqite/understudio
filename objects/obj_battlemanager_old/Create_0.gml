/// @description Initialize the variables
depth = depth_battle.ui;

sel[0] = 0; // Selection
sel[1] = 0; // Fight
sel[2] = 0; // Act
sel[3] = 0; // Item
sel[4] = 0; // Mercy

state = 0;
fleeable = true;
spareable = true;

for (var i = 0; i < 6; i++;) {
	actName[i] = "Smooch";
}

box_id_prev = global.board;
turn_time = 180;
ready = false;

goldReward = irandom(5);
xpReward = irandom(3);
chance = irandom(100); // For fleeing
cooldown = 0;

wroteIntroString = false;

obj_gamecamera.target = noone;
obj_gamecamera.xScale = 1;
obj_gamecamera.yScale = 1;
global.currentsong = "battle";
instance_create(0, 0, obj_unfader);