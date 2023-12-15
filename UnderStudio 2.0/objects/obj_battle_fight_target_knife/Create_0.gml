/// @description Initialize

var _board = obj_battleboardhandler;

x = _board._x;
y = _board._y;

targetDMG = 0;
targetHitExecutedOnce = false;
targetFade = false;

barX = x - sprite_width / 2;
barY = y;

execute_tween(id, "barX", x + sprite_width / 2, "linear", 2, false);