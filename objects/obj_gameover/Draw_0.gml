if (phase >= 1) {
	draw_set_alpha(alpha);
	draw_sprite(spr_gameover_header, 0, room_width / 2, room_height / 4);
	
	draw_set_alpha(1);
}
if (!instance_exists(obj_heart_shard)) && (ready == false) {
	draw_self();
}