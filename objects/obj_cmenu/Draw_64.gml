height = camera_get_view_height(view_current);
shift = obj_player.y > height / 2;
moveyy = (shift ? 270 : 0);

draw_box(32, 32 + moveyy, 172, 140 + moveyy);
draw_box(32, 148, 172, 294);

draw_set_font(fnt_dialogue);
draw_set_color(c_white);
draw_text(46, 42 + moveyy, string_hash_to_newline(string(global.name)));

draw_set_font(fnt_crypt);
draw_text(46, 80 + moveyy, string_hash_to_newline("LV  " + string(global.lv)));
draw_text(46, 98 + moveyy, string_hash_to_newline("HP  " + string(global.hp) + "/" + string(global.maxhp)));
draw_text(46, 116 + moveyy, string_hash_to_newline("G   " + string(global.gold)));
draw_set_font(fnt_dialogue);
draw_sprite_ext(spr_heartsmall, 0, 56, 183 + (36 * sel[0]), 2, 2, 0, c_white, 1);

if (ds_list_empty(global.inv_item))
    draw_set_color(c_gray);
else
    draw_set_color(c_white);

draw_text(84, 168, string_hash_to_newline("ITEM"));
draw_set_color(c_white);
draw_text(84, 204, string_hash_to_newline("STAT"));
draw_text(84, 240, string_hash_to_newline("CELL"));

