draw_set_color(c_black);
draw_rectangle(__view_get( e__VW.XView, view_current ) + -10, __view_get( e__VW.YView, view_current ) + -10, __view_get( e__VW.XView, view_current ) + 330, __view_get( e__VW.YView, view_current ) + 250, false);

draw_set_color(c_white);

if (phase < 3) {
    draw_sprite(obj_player.sprite_index, 0, obj_player.x, obj_player.y);
}

if (draw_soul == true) {
    draw_sprite(spr_heartsmall, 0, draw_soul_x, draw_soul_y);
}

draw_set_color(c_white);

