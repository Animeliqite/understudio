surface_set_target(global.drawingSurface);
draw_set_color(color);
draw_set_alpha(alpha);
draw_rectangle(0, 0, 640, 480, false);

draw_set_color(c_white);
draw_set_alpha(1);

surface_reset_target();