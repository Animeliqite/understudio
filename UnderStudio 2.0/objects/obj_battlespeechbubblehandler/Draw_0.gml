draw_sprite_stretched_ext(bubble, 0, x, y, width, height, c_white, 1);

if (arrow_draw) {
	switch (dir) {
		case DIR_UP:
			draw_sprite_ext(arrow, arrow_index, x + width / 2, y, 1, 1, 90, c_white, 1);
			break;
		case DIR_DOWN:
			draw_sprite_ext(arrow, arrow_index, x + width / 2, y + height, 1, 1, 270, c_white, 1);
			break;
		case DIR_LEFT:
			draw_sprite_ext(arrow, arrow_index, x, y + height / 2, 1, 1, 180, c_white, 1);
			break;
		case DIR_RIGHT:
			draw_sprite_ext(arrow, arrow_index, x + width, y + height / 2, 1, 1, 0, c_white, 1);
			break;
	}
}

if (instance_exists(writer))
	draw_rpgtext(x + 15, y + 12, writer.written, writer_font, 1, 10, 18, 1, 1, c_black);