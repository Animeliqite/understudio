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

if (instance_exists(writer)) {
	draw_text_extended(x + 15, y + 12, writer.raw_text, {
		halign: fa_left,
		valign: fa_top,
		size: 1,
		visible: writer.visible_chars,
		font: writer_font,
		alpha: 1,
		color: c_black,
		effect: "none",
		letter_width: 10,
		letter_height: 18,
		letter_spacing: 0,
		line_spacing: 1,
		line_break: -1
	});
}