application_surface_draw_enable(false);

if (global.drawingSurface == -1 || !surface_exists(global.drawingSurface)) 
	global.drawingSurface = surface_create(1024, 512);

surface_set_target(global.drawingSurface);
draw_clear_alpha(c_black, 0);
surface_reset_target();