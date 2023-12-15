/// @description Initialize

barWidth = 100;
barHeight = 10;
barYOffset = 20;
barRemainingColor = c_lime;
barBackColor = c_gray;

dmgAmount = 0;
hpOld = 0;

dmgFont = font_add_sprite_ext(spr_battle_dmg, "0123456789.", false, 2);
dmgX = 0;
dmgY = 0;

jumpAmount = -3;
jumped = false;

alarm[2] = 1;