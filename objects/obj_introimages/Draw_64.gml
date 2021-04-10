/// @description Draw additional things
surface_set_target(global.drawingSurface);
draw_sprite_ext(lastImage, 0, lastImage_x, lastImage_y, 2, 2, 0, c_white, lastImage_alpha);

draw_set_color(c_black);
draw_rectangle(0, 0, 639, 56, false);
draw_rectangle(0, 0, 120, 479, false);
draw_rectangle(0, 276, 639, 479, false);
draw_rectangle(520, 0, 639, 479, false);
surface_reset_target();