progressQuick = false;
showBubble = true;
animateSoul = true;

drawSoulX = obj_player.x;
drawSoulY = obj_player.y;
drawSoul = false;
drawSoulTween[0] = -1;
drawSoulTween[1] = -1;

soulTargetX = obj_gamecamera.x + 20 - (sprite_get_width(spr_heartsmall) / 2);
soulTargetY = obj_gamecamera.y + 230 - (sprite_get_height(spr_heartsmall) / 2);

depth = depth_overworld.ui_high;
blinkingPhase = 0;
phase = 0;