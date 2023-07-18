draw_ftext(30, 400, global.playerName + "   LV " + string(global.playerLV), fnt_battle, c_white);

draw_sprite_ext(spr_hp_name, 0, 240, 400, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_pixel, 0, 275, 400, global.playerHP._max * 1.2, 20, 0, c_maroon, 1);
draw_sprite_ext(spr_pixel, 0, 275, 400, global.playerHP._curr * 1.2, 20, 0, c_yellow, 1);

draw_ftext(275 + global.playerHP._max * 1.2 + 20, 400, string(global.playerHP._curr) + " / " + string(global.playerHP._max), fnt_battle, c_white);