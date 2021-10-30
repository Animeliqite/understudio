/// @description Draw the error info
draw_text_style_scaled("The game has unexpectedly crashed!\nPlease contact the developers.", 40, 40, fnt_dialogue, c_white, fa_left, fa_top, 1.33, 1.33, 0); 

draw_set_font(fnt_dialogue);
draw_set_color(c_white);
draw_text_ext_transformed(40, 140, "Extra info:\n" + string_hash_to_newline(msg), string_height("A"), (room_width + 120) * 2, 0.6, 0.6, 0);

draw_sprite_ext(spr_crashdog, dogIndex, (room_width * 2) - 60, (room_height * 2) - 60, 3, 3, dogAngle, c_white, 1);