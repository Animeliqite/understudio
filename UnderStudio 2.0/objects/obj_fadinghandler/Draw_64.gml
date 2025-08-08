/// @description Draw the fader

var colorOld = draw_get_color(), alphaOld = draw_get_alpha();
var w = display_get_gui_width(), h = display_get_gui_height();

draw_set_color(faderColor);
draw_set_alpha(faderAlpha);
draw_rectangle(0, 0, w, h, false);

draw_set_color(colorOld);
draw_set_alpha(alphaOld);