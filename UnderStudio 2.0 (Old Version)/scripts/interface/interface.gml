function draw_rpgtext(_x, _y, text, font = fnt_main, alpha = 1, charWidth = global.mainFontWidth, charHeight = global.mainFontHeight, scaleX = 1, scaleY = 1, color = c_white) {
	var effect = 0;
	var siner = 0;
	
	var cx = _x, cy = _y;
	for (var i = 1; i < string_length(text) + 1; ++i) {
		var c = string_char_at(text, i);
		
		switch (c) {
			case "`":
				i++;
				var cNext = string_char_at(text, i);
				switch (cNext) {
					case "c":
						i++;
						var colorCheck = string_char_at(text, i);
						switch (colorCheck) {
							case "W": color = c_white; break;
							case "X": color = c_black; break;
							case "B": color = c_blue; break;
							case "Y": color = c_yellow; break;
							case "R": color = c_red; break;
						}
						break;
					case "e":
						i++;
						effect = string_char_at(text, i);
						break;
					case "s":
						i++;
						var spriteCheck = string_char_at(text, i);
						switch (spriteCheck) {
							case "Z": draw_sprite_ext(spr_gpbuttons_confirm, 0, cx, cy + 5, scaleX * 2, scaleY * 2, 0, c_white, 1); break;
							case "X": draw_sprite_ext(spr_gpbuttons_cancel, 0, cx, cy + 5, scaleX * 2, scaleY * 2, 0, c_white, 1); break;
							case "C": draw_sprite_ext(spr_gpbuttons_menu, 0, cx, cy + 5, scaleX * 2, scaleY * 2, 0, c_white, 1); break;
						}
						cx += (charWidth != -1 ? charWidth : string_width(c)) + (24 * scaleX);
						break;
					default:
						i--;
						break;
				}
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