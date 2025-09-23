if (instance_exists(col)) {
	var _bbox_top = col.bbox_top;
	
	if (!surface_exists(surf)) {
		draw_sprite_ext(sprite, 0, x, y, xscale, yscale, 0, c_white, 1);
		
		surf = surface_create(1024, 1024);
	}
	else {
		surface_set_target(surf);
		draw_sprite_ext(sprite, 0, x, y, xscale, yscale, 0, c_white, 1);
		surface_reset_target();
		draw_surface_part(surf, 0, _bbox_top + anim_h, 640, 480, 0, _bbox_top + anim_h);
	}
}
else {
	draw_sprite_ext(sprite, 0, x, y, xscale, yscale, 0, c_white, 1);
}