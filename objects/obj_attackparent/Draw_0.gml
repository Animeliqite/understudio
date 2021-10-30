var bm = obj_battlemanager;
if (!surface_exists(surface)) {
    surface = surface_create(1024, 512);
}
else {
	surface_set_target(surface);
	draw_clear_alpha(c_black, 0);
	x -= (bm.boardX1 + 5);
	y -= (bm.boardY1 + 5);
	draw_self();
	x += (bm.boardX1 + 5);
	y += (bm.boardY1 + 5);
	surface_reset_target();
	draw_surface_part(surface, 0, 0, bm.boardX2 - bm.boardX1 - 10, bm.boardY2 - bm.boardY1 - 10, bm.boardX1 + 5, bm.boardY1 + 5);
}