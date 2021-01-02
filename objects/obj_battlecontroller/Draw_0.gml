/// @description Draw the UI

draw_set_color(c_white);
draw_box(obj_uborder.x, obj_uborder.y, obj_dborder.x, obj_dborder.y);

draw_set_font(fnt_mars);
draw_text(30, 400, string_hash_to_newline(string(global.name) + "   LV " + string(global.lv)));

draw_set_color(merge_colour(c_red, c_maroon, 0.5));
draw_rectangle(255, 400, 255 + (global.maxhp * 1.2), 420, false);

draw_set_color(c_yellow);
draw_rectangle(255, 400, 255 + (global.hp * 1.2), 420, false);

draw_set_color(c_white);
draw_sprite(spr_hpicon, 0, 220, 400);

draw_text(275 + (global.maxhp * 1.2), 400, string_hash_to_newline(string(global.hp) + " / " +  string(global.maxhp)));

