/// @description Draw necessary things

var w = display_get_gui_width(), h = display_get_gui_height();
draw_sprite_ext(spr_titletext, 0, w / 2, h / 2, 2, 2, 0, c_white, real(showTitle));

draw_set_font(fnt_crypt);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(real(showAlternateText));
draw_set_color(c_gray);
draw_text_transformed(w / 2, h / 1.45, "[PRESS Z OR ENTER]", 0.5, 0.5, 0);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);