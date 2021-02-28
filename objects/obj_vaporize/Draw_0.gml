if (_y == 0) {
	draw_sprite_ext(body.sprite_index, 0, x, y, body.image_xscale, body.image_yscale, 0, body.image_blend, 1);
}
else {
	if (!surface_exists(surface))
		surface = surface_create(1024, 1024);
	
	surface_set_target(surface); {
		draw_clear_alpha(c_black, 0);
		draw_sprite_ext(body.sprite_index, 0, x, y, body.image_xscale, body.image_yscale, 0, body.image_blend, 1);
	}
	surface_reset_target();
	draw_surface_part(surface,0, _y, 640, 480-_y, 0, _y);
}