/// @description Frisk Dance
var check = (global.up_hold) && (global.down_hold);
dance = !dance;
image_speed = moveSpeed / 30;

alarm[0] = (check ? 1 : -1)