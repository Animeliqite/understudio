shift = obj_player.y > __view_get( e__VW.YView, view_current ) + 120;
xx = __view_get( e__VW.XView, view_current );
yy = __view_get( e__VW.YView, view_current );

if (shift == true)
    moveyy = 135;
else
    moveyy = 0;

draw_box(xx + 16, yy + 16 + moveyy, xx + 86, yy + 70 + moveyy);
draw_box(xx + 16, yy + 74, xx + 86, yy + 147);

draw_set_font(fnt_dialogue);
draw_set_color(c_white);
draw_text(xx + 23, yy + 20 + moveyy, string_hash_to_newline(string(global.name)));

draw_set_font(fnt_crypt);
draw_text(xx + 23, yy + 40 + moveyy, string_hash_to_newline("LV  " + string(global.lv)));
draw_text(xx + 23, yy + 49 + moveyy, string_hash_to_newline("HP  " + string(global.hp) + "/" + string(global.maxhp)));
draw_text(xx + 23, yy + 58 + moveyy, string_hash_to_newline("G   " + string(global.gold)));

draw_set_font(fnt_dialogue);

if (sel[0] == 0)
    draw_sprite(spr_heartsmall, 0, xx + 28, yy + 88);
else if (sel[0] == 1)
    draw_sprite(spr_heartsmall, 0, xx + 28, yy + 106);
else if (sel[0] == 2)
    draw_sprite(spr_heartsmall, 0, xx + 28, yy + 124);

if (global.item[0] == 0)
    draw_set_color(c_gray);
else
    draw_set_color(c_white);

draw_text(xx + 42, yy + 84, string_hash_to_newline("ITEM"));

draw_set_color(c_white);

draw_text(xx + 42, yy + 102, string_hash_to_newline("STAT"));
draw_text(xx + 42, yy + 120, string_hash_to_newline("CELL"));

