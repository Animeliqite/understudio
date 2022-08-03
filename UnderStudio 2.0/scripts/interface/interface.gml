function draw_rpgtext(_x, _y, text, font = fnt_main, alpha = 1, charWidth = global.mainFontWidth, charHeight = global.mainFontHeight, scaleX = 1, scaleY = 1, color = c_white) {
	var effect = 0;
	var siner = 0;
	
	var cx = _x, cy = _y;
	for (var i = 1; i < string_length(text) + 1; ++i) {
		var c = string_char_at(text, i);
		
		switch (c) {
			case "`":
				i++;
				if (string_copy(text, i, 5) == "color") {
					i += 6;
					if (string_copy(text, i, 5) == "white") {
						color = c_white;
						i += 5;
					}
					if (string_copy(text, i, 5) == "black") {
						color = c_black;
						i += 5;
					}
					if (string_copy(text, i, 4) == "blue") {
						color = c_blue;
						i += 4;
					}
					if (string_copy(text, i, 6) == "yellow") {
						color = c_yellow;
						i += 6;
					}
					if (string_copy(text, i, 3) == "red") {
						color = c_red;
						i += 3;
					}
				}
				else if (string_copy(text, i, 6) == "effect") {
					i += 7;
					effect = real(string_char_at(text, i));
					i++;
				}
				else if (string_copy(text, i, 6) == "sprite") {
					i += 7;
					if (string_copy(text, i, 8) == "button_z") {
						i += 8;
						draw_sprite_ext(spr_gpbuttons_confirm, 0, cx, cy + 5, scaleX * 2, scaleY * 2, 0, c_white, 1);
					}
					if (string_copy(text, i, 8) == "button_x") {
						i += 8;
						draw_sprite_ext(spr_gpbuttons_cancel, 0, cx, cy + 5, scaleX * 2, scaleY * 2, 0, c_white, 1);
					}
					if (string_copy(text, i, 8) == "button_c") {
						i += 8;
						draw_sprite_ext(spr_gpbuttons_menu, 0, cx, cy + 5, scaleX * 2, scaleY * 2, 0, c_white, 1);
					}
					cx += (charWidth != -1 ? charWidth : string_width(c)) + (24 * scaleX);
				}
				i--;
				break;
			case "#":
				cx = _x;
				cy += (charHeight != -1 ? charHeight : string_height(c));
				break;
			default:
				siner++;
				draw_set_color(color);
				draw_set_alpha(alpha);
				draw_set_font(font);
				
				switch (effect) {
					default:
					case 0:
						draw_text_transformed(cx, cy, c, scaleX, scaleY, 0);
						break;
					case 1:
						draw_text_transformed(cx + irandom(1), cy + irandom(1), c, scaleX, scaleY, 0);
						break;
					case 2:
						draw_text_transformed(cx + cos(current_time / 125 + siner) * 1.5, cy + sin(current_time / 125 + siner) * 1.5, c, scaleX, scaleY, 0);
						break;
				}
				
				cx += (charWidth != -1 ? charWidth : string_width(c));
				break;
		}
	}
}

function draw_ftext(_x, _y, text, font = fnt_main, color = c_white, alpha = 1, xscale = 1, yscale = 1, angle = 0, halign = fa_left, valign = fa_top) {
	// Initialize the variables
	var prevFont = draw_get_font(),
		prevAlpha = draw_get_alpha(),
		prevColor = draw_get_color(),
		prevHAlign = draw_get_halign(),
		prevVAlign = draw_get_valign();
	
	// Initialize everything
	draw_set_font(font);
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_alpha(alpha);
	draw_set_color(color);
	
	// Draw the text
	draw_text_transformed(_x, _y, text, xscale, yscale, angle);
	
	// Reset values
	draw_set_font(prevFont);
	draw_set_halign(prevHAlign);
	draw_set_valign(prevVAlign);
	draw_set_alpha(prevAlpha);
	draw_set_color(prevColor);
}