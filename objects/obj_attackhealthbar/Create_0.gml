/// @description Set up the variables
currentMonster = obj_battlemanager.monsters[bt_getcurrent_monster()];

newHP = obj_battlemanager.monsterHP[bt_getcurrent_monster()];
barDuration = room_speed * 1.5;
barColor = [c_gray, c_lime];
barWidth = 125;
damage = 0;

vspeed = -3;
gravity = 0.3;
alarm[1] = 2;

depth = depth_battle.bullet_higher;
obj_battlemanager.stateSelection = 3;