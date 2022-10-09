/// @description Draw the fader

var colorOld = draw_get_color(), alphaOld = draw_get_alpha();
draw_set_color(faderColor);
draw_set_alpha(faderAlpha);
draw_rectangle(0, 0, 640, 480, false);

draw_set_color(colorOld);
draw_set_alpha(alphaOld);