/// @description Draw necessary things

// Initialize the variables
var w = display_get_gui_width(), h = display_get_gui_height();

// Draw necessary stuff
draw_sprite_ext(spr_titletext, 0, w / 2, h / 2, 2, 2, 0, c_white, real(showTitle));
draw_ftext(w / 2, h / 1.45, "[PRESS Z OR ENTER]", fnt_crypt, c_gray, real(showAlternateText), 0.5, 0.5, 0, fa_center, fa_middle);