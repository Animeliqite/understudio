/// @description Draw the sprite

if (!surface_exists(surf))
	surf = surface_create(1024, 512);
else {
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	draw_sprite_tiled_ext(sprite_index, image_index, x, y, 1, 1, image_blend, image_alpha);
	surface_reset_target();
		
	draw_surface_part(surf, 0, 0, image_xscale * sprite_width, image_yscale * sprite_height, x, y);
}