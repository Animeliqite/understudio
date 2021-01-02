draw_soul_x = obj_player.x - (sprite_get_width(spr_heartsmall) / 2);
draw_soul_y = obj_player.y - (sprite_get_height(spr_heartsmall) / 2);

soul_target_x = __view_get( e__VW.XView, view_current ) + 20;
soul_target_y = __view_get( e__VW.YView, view_current ) + 220;

draw_soul = false;

phase = -1;

alarm[0] = 4;

mus_pause(global.currentsong);

global.cutscene = true;

